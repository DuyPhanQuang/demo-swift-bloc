# demo-swift-bloc

iOS Project based on SwiftUI & BLoC Pattern

## Getting Started

This project is a iOS app demo that building by Swift.

## Awareness
- Always think about the million users are using this app, so it must be the **World Class** app
- Coding is not just feature done, it's the **reflection of success**
- To get the best quality, must have the **best solution**
- Always think about & follow up **SOLID principal** for every solutions
- Naming is **VERY IMPORTANT**, it's not coding, it's solution

## Architecture

Apply Clean Architecture + BLoC pattern 
```
|-----------------  Layers  ------------------|
| Presentations | Business Logic | Data Layer |
|:-------------------------------------------:|

|--------------------------  Actual  -------------------------------|
| Presentations  |      Business Logic    |         Data            |
|:-----------------------------------------------------------------:|
| Module <--> Bloc <--> Interactor <--> Repository <--> Service/DAO |
|:-----------------------------------------------------------------:|
|:----  Extension Entity   ----|----    Basic Entity   ------------:|
|:-----------------------------------------------------------------:|
```
### Modules
- This is the major view layer of iOS app and is categorized by module (feature or epic). 
- View is rendered based on the bloc state if needed. 
- View that are used across module will be placed in *CommonUI folder* and **MUST NOT** build based on bloc state.
- A view or screen can have multiple blocs to control UI's state or no blocs at all.

Examples of a standard view that build based on bloc states:
```swift
    @EnvironmentObject var contactBloc: ContactBloc
    
    var body: some View {
        BlocView(builder: { (bloc) in
            let contact = bloc.state.contact
            HStack(alignment: .center) {
                AvatarView(avatar: contact.avatar, size: 32)
                VStack(alignment: .leading) {
                    Text(contact.fullName())
                        .primaryBold(fontSize: 15)
                    Text("age: \(contact.age())")
                        .secondaryRegular(color: .gray)
                }
                .foregroundColor(.black)
                Spacer()
            }
            .frame(minHeight: 44, maxHeight: 44, alignment: .center)
        }, base: contactBloc)
    }
```

### BLoC
- It's the main stateful layer that keep all app's state and data.
- Data must keep in State class, not in bloc itself 
- Bloc can handle all UI's business, such as proceed an user's action, control loading flow or update new language, ... All UIs that need update by state, it's responsible of Bloc
- Bloc is managed through by BlocManager, control constructor and dispose, communicate between blocs by add event or listen state changes, and even for broadcast on global channel
- The naming convention to define Event and State class can reference [here](https://bloclibrary.dev/#/blocnamingconventions)
- State class **MUST** be extended by Equatable, but Event class.
- BaseBloc is advanced class of Bloc to handle some generic business such as show/hide app loading (locked loading), handle callApi with common error handling.
- Bloc key is required for all blocs, use Constants to define key.
- Bloc can reference to multiple interactors to handle business, but less is better.

Example of Bloc new instance:
```swift
    func contactListBloc() -> LoadListBloc<Contact> {
        let key = Keys.Bloc.contactList
        let bloc = BlocManager.shared.newBloc(LoadListBloc<Contact>.self, key: key) {
            return LoadListBloc<Contact>(
                key: key,
                interactor: Interactors().contactListInteractor()
            )
        }
        return bloc as! LoadListBloc<Contact>
    }
```

and provide Bloc into View in Route:
```swift
    let contactList = NavigationRoute(path: "/contactList") {
        ContactListView()
            .provideBloc(create: {
                BlocConstructors().contactListBloc()
            })
    }
```

### Interactor
- It's the main layer to handle all data business
- It's a stateless layer, so it will be constructed on demand
- A service may contain many usecases that belong to a same module or epic
- A service can communicate with other services
- All interactors **MUST** be defined with an interface (abstract class), bloc communicate with interactor through by the interface 
- Constructor in Interactor class (DI class)

```swift
    class Interactors {
      func contactInteractor() -> ContactInteractor {
          return ContactInteractorImpl(contactRepository: Repositories.shared.contactRepository())
      }

      // list contact interactor
      func contactListInteractor() -> LoadListInteractor<Contact> {
          return ContactListInteractorImpl(contactRepository: Repositories.shared.contactRepository())
      }
  }
```

### Repository
- It's imported from local framework project name *Repository*
- The main data source of app that is used by interactor layer
- It's a stateless layer, so it will be constructed on demand
- It contains a little bit business rules to branch data source that should be used, from client or dao
- It also handle the caching logic rules, from memory or local storage
- All repositories **MUST** be defined with an interface (abstract class), interactor communicate with repository through by the interface 
- Constructor in Repository class (DI class)

```swift
    public class Repository {
        public static let shared = Repository()

        // Repository
        public func contactRepository() -> ContactRepository {
            return ContactRepositoryImpl(
                contactDao: contactDao(), contactService: contactService()
            )
        }

        // Service
        func contactService() -> ContactService {
            return ContactServiceImpl()
        }

        // Dao
        func contactDao() -> ContactDao {
            return ContactDaoImpl()
        }
    }
```

### Service/Dao
- It's data source layer, client means data is from RestFul API and Dao means data is from local storage
- BaseService is advanced class to handle all generic calling API, retry when access token is expired and need to refresh, also for general API error handling
- BaseDao is advanced class to handle the generic storage, save/get list or item, or even for a string or an integer
- All Service & Dao **MUST** be defined with an interface (abstract class), repository communicate with service/dao through by the interface 

### Model
- It covers all entities in app
- Have 2 kind of models, basic entity and extension entity.
- Basic entity is belong to repository, it defines all entity's properties and support basic parsing with JSON
- Extension entity is belong to UI layer, it defines all utility methods of an entity
- All entity **MUST** extended by Equatable that useful in smart comparation

## Dependencies Injection
- There are 3 kinds of class to support construct instance for DI, BlocManager, Interactors and Repository
- Blocs provide the instance of Bloc
- Interactors is a singleton class that provide the instance of interactor.
- Repository is a singleton class that provide the instance of repository, service & dao

* All initialization of Bloc MUST be from BlocManager. It's a singleton that responsibility to manage all Blocs by Key/Value. It's not only handle all life cycle of Bloc, but also provide the fast way to get instance or proceed Event of Bloc by Key
```swift
    func loadingBloc() -> LoadingBloc {
        return BlocManager.shared.newBloc(key: Keys.Bloc.loadingBloc) {
            return LoadingBloc(key: Keys.Bloc.loadingBloc)
        }
    }
```

## Code Structure
Here is list all of key folders or files in code structure:
```
.
|-- demo-swift-bloc            *store all assets that are font, icon, image, video or animation*
|   |-- demo-swift-bloc 
|   |   |-- Bloc                            *all blocs that need in project*
|   |       |-- language                    *each bloc has a folder with name of bloc only*
|   |           |-- language_bloc.dart      *the Bloc class that extends of BaseBloc*
|   |           |-- language_event.dart     *define all Event class, must follow the naming convention strongly*
|   |           |-- language_state.dart     *define all State class that extends of Equatable, must follow the naming convention*
|   |           |-- language.dart           *the index file that export all files in bloc folder*
|   |   |-- Configurations                  *All configurations needed for each environment
|   |       |-- DEV.xcconfig                    *Configurations for Development environment
|   |       |-- QC.xcconfig                     *Configurations for QA environment
|   |       |-- PROD.xcconfig                   *Configurations for Production environment
|   |   |-- Extensions                      *All foundation extensions class, such as String, Int, Date, ...
|   |   |-- Routing                         *define all Routers in application
|   |   |-- Theme                           *includes Design Tokens to manage all Styles such as font, size, color, spacing
|   |   |-- Constant                        *define all constant values such Keys, Strings, ...*
|   |   |-- Global                          *includes all global task such as Analytics, Messages, ...
|   |   |-- Model                           *define all extension entities and all entities that need in UI layer*
|   |   |-- Modules                         *define all UI Views that categorized by module or epic*
|   |   |-- Interactor                      *define all interactor classes*
|   |   |-- Utils                           *define all utility classes*
|   |   |-- CommonUI                        *define all common Views and can use across modules but not use bloc inside*
|   |   |-- 3rdParty                        *includes 3rd party that need to customize such as SwiftUIRouter
|   |   |-- demo_swift_blocApp.swift                       *the main class that app launch from*
|   |-- demo-swift-blocTests       *unit testing for Blocs & Interactors
|-- Repository
|   |-- Repository
|   |   |-- Service                     *define all service classes*
|   |   |-- Dao                         *define all dao classes*
|   |   |-- Enum                        *define all enum*
|   |   |-- Model                       *define all basic entities*
|   |   |-- Repository                  *define all repository classes*
|   |   |-- Repository.swift            *Repository class, singleton class that support DI for data layer*
|   |-- RepositoryTests                 *unit testing for repository (Repository, Dao, Service, ...), require testing for repositorry only*
```

## Storybook
It's used for view all common view (only view that are not based on bloc should be build). It MUST cover all view that in CommonUI.

How to add view into storybook:

Create a story file to add view into. A story file should cover all states of the view, not only the happy case.
```swift
    struct ButtonViewStory: View {
    var body: some View {
        VStack {
            SpacerView(height: 128)
            ButtonView.primary("Primary Button") {
                print("Primary Action Now!")
            }
            .padding(.horizontal, 32)
            SpacerView(height: 128)
            ButtonView.primary("Padding Button", padding: EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)) {
                print("Padding Action Now!")
            }
            SpacerView(height: 128)
            ButtonView.secondary("Secondary Button") {
                print("Secondary Action Now!")
            }
            .padding(.horizontal, 32)
            SpacerView(height: 128)
            ButtonView.secondary("Secondary Padding", padding: EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)) {
                print("Secondary Padding Now!")
            }
            SpacerView(height: 128)
        }
    }
}
```


## Router
Define all Routers using in app, includes all parameters, BlocProvider, ...:
```swift
    static var all: [NavigationRoute] {
        let splash = NavigationRoute(path: "/splash", destination: SplashView())
        let storyBook = NavigationRoute(path: "/storyBook", destination: Storybook())
        
        let contactList = NavigationRoute(path: "/contactList") {
            ContactListView()
                .provideBloc(create: {
                    BlocConstructors().contactListBloc()
                })
        }
        
        let contactDetails = NavigationRoute(path: "/contact/{id}") { route in
            ContactDetailView()
                .provideBloc(create: {
                    BlocManager.shared.blocByKey(
                        key: Keys.Bloc.contactBlocById(id: route.link.meta["contactId"] as! String)
                    ) as! ContactBloc
                })
        }
        
        return [splash, storyBook, contactList, contactDetails]
    }
```

Navigate to new screen:
```swift
    @Environment(\.router) var router

    Button(action: {
        router.push(link: .contactDetails(with: contact.id))
    }, label: {
        ContactRowItem()
            .provideBloc(create: { BlocConstructors().contactBloc(contact: contact) })
    })
```

## Design System
Handle all Design System in Theme folder. DesignTokens is generated by Design System that we DO NOT ALLOW to edit it.
```swift
    public class DesignTokens {
        public static let colorBaseGrayDark = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        public static let colorBaseGrayLight = UIColor(red: 0.800, green: 0.800, blue: 0.800, alpha: 1)
        public static let colorBaseGrayMedium = UIColor(red: 0.600, green: 0.600, blue: 0.600, alpha: 1)
        public static let colorBaseGreen = UIColor(red: 0.000, green: 1.000, blue: 0.000, alpha: 1)
        public static let colorBaseOrange = UIColor(red: 1.000, green: 0.647, blue: 0.000, alpha: 1)
        public static let colorBaseRed = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1)
        public static let colorFontBase = UIColor(red: 0.000, green: 1.000, blue: 0.000, alpha: 1)
        public static let colorFontSecondary = UIColor(red: 0.000, green: 1.000, blue: 0.000, alpha: 1)
        public static let colorFontTertiary = UIColor(red: 0.800, green: 0.800, blue: 0.800, alpha: 1)

        public static let sizeFontBase = CGFloat(16.00) /* the base size of the font */
        public static let sizeFontLarge = CGFloat(32.00) /* the large size of the font */
        public static let sizeFontMedium = CGFloat(16.00) /* the medium size of the font */
        public static let sizeFontSmall = CGFloat(12.00) /* the small size of the font */

        public static let fontFamilyPrimary = "Helvetica"
        public static let fontFamilySecondary = "Arial"
    }
```

We use DesignTokens to define all Styles in application such as Color, Text, Spacing, ...
```swift
    extension Text {
        public func primaryRegular(fontSize: CGFloat =  13, color: Color = Color.primaryTextColor) -> Text {
            return self.font(
                    .custom(DesignTokens.fontFamilyPrimary, size: fontSize)
                )
                .foregroundColor(color)
        }

        public func primaryBold(fontSize: CGFloat =  13, color: Color = Color.primaryTextColor) -> Text {
            return self.primaryRegular(fontSize: fontSize, color: color)
                .fontWeight(.bold)
        }

        public func secondaryRegular(fontSize: CGFloat =  13, color: Color = Color.primaryTextColor) -> Text {
            return self.font(
                    .custom(DesignTokens.fontFamilySecondary, size: fontSize)
                )
                .foregroundColor(color)
        }
    }
```

then, ONLY using all styles in application through by all defined-styles
```swift
    Text("\(contact.age())")
        .primaryRegular(fontSize: 17)
        .foregroundColor(.black)
```

```

And match parameter from .xcconfig in Configs class, a singleton class stores all configurations. All parameters are read from AppEnvironment class.
```swift
    final class Configs {
        static let shared = Configs()

        var isStorybook: Bool

        init() {
            isStorybook = AppEnvironment.isStorybook
        }
    }
```

## Testing
- All Blocs **MUST** have unit testing for all Events and StreamSubscriptions, except static constructor.
- All Interactors **MUST** have unit testing for all public methods.
- All Repositories **MUST** have unit testing for all public methods.

## Logging
- Support logging for 6 standard levels of logs, here is lists (order by the priority of log)
  1. fatal: *for any issuse that kill the app or business*
  2. error: *for any exception that the app catch*
  3. warning: *for any potential error, invalid data or unexpected value that cause lead to error*
  4. info: *for log actions or events from end-user*
  5. debug: *for debug purpose and will not see in production, only see in development or testing mode*
  6. trace: *for tracking in order to identify bugs, do not keep it when bug is resolved*
- The logging level for each environment will be set in .env files
- The Log class is a singleton and be able to get from singleton instance of Common class

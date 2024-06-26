//
//  Routes.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Repository
import SwiftUI
import SwiftBloc

extension NavigationRouteLink {
    static var splash: NavigationRouteLink { "/splash" }
    static var storyBook: NavigationRouteLink { "/storyBook" }
    static var contactList: NavigationRouteLink { "/contactList" }
    
    static func contactDetail(with contactId: String) -> NavigationRouteLink {
        NavigationRouteLink(path: "/contact/\(contactId)", meta: ["contactId": contactId])
    }
}

extension Array where Element == NavigationRoute {
    static var all: [NavigationRoute] {
        let splash = NavigationRoute(path: "/splash", destination: SplashScreen())
//        let storyBook = NavigationRoute(path: "/storyBook", destination: Storybook())
        let contactList = NavigationRoute(path: "/contactList") {
            ContactListScreen()
                .provideBloc(create: {
                    BlocConstructors().contactListBloc()
                })
        }
        let contactDetail = NavigationRoute(path: "/contact/{id}") { route in
            ContactDetailScreen()
                .provideBloc(create: {
                    BlocManager.shared.blocByKey(
                        key: Keys.Bloc.contactBlocById(id: route.link.meta["contactId"] as! String)
                    ) as! ContactBloc
                })
        }
        
        return [splash, contactList, contactDetail]
    }
}

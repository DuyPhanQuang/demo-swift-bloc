//
//  ContactListScreen.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import SwiftUI
import SwiftBloc
import Repository

struct ContactListScreen: View {
    @Environment(\.router) var router
    
    var body: some View {
        LoadListView<Contact>(pullToRefresh: true, isLoadMore: false) { contact in
            return AnyView(
                Button(action: {
                    router.push(link: .contactDetail(with: contact.id))
                }, label: {
                    ContactRowItem()
                        .provideBloc(create: { BlocConstructors().contactBloc(contact: contact) })
                })
            )
        } itemKey: {
            return $0.id
        }
        .navigationTitle("Contacts")
    }
}

struct ContactRowItem: View {
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
}

struct ContactListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactListScreen()
    }
}


//
//  Blocs.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import Repository

class BlocConstructors {
    // Common
    func loadingBloc() -> LoadingBloc {
        return BlocManager.shared.newBloc(key: Keys.Bloc.loadingBloc) {
            return LoadingBloc(key: Keys.Bloc.loadingBloc)
        }
    }
    
    // Single
    func contactBloc(contact: Contact) -> ContactBloc {
        let key = Keys.Bloc.contactBlocById(id: contact.id)
        return BlocManager.shared.newBloc(key: key) {
            return ContactBloc(
                key: key,
                closeWithBlocKey: Keys.Bloc.contactList,
                contact: contact,
                interactor: Interactors().contactInteractor()
            )
        }
    }
    
    // Load x list
    func contactListBloc() -> LoadListBloc<Contact> {
        let key = Keys.Bloc.contactList
        let bloc = BlocManager.shared.newBloc(key: key) {
            return LoadListBloc<Contact>(
                key: key,
                interactor: Interactors().contactListInteractor()
            )
        }
        return bloc
    }
}




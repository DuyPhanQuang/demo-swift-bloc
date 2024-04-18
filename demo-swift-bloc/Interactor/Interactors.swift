//
//  Interactor.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import Repository

// Dependency Injection for Interactor layer
class Interactors {
    func contactInteractor() -> ContactInteractor {
        return ContactInteractorImpl(contactRepository: Repositories.shared.contactRepository())
    }
    
    // list service
    func contactListInteractor() -> LoadListInteractor<Contact> {
        return ContactListInteractorImpl(contactRepository: Repositories.shared.contactRepository())
    }
}

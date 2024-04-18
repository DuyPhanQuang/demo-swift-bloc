//
//  ContactInteractorImpl.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import Combine
import Repository

public class ContactInteractorImpl: ContactInteractor {
    private var contactRepository: ContactRepository!
    
    public init(contactRepository: ContactRepository) {
        self.contactRepository = contactRepository
    }
    
    public func editContactById(contact: Contact) -> Future<Contact, Error> {
        return contactRepository.editContact(contact: contact)
    }
}

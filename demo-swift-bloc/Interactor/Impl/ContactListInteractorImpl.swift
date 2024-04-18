//
//  ContactListInteractorImpl.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import Combine
import Repository

public class ContactListInteractorImpl: LoadListInteractor<Contact> {
    private var contactRepository: ContactRepository
    
    public init(contactRepository: ContactRepository) {
        self.contactRepository = contactRepository
    }
    
    override func forceToRefresh() {
        contactRepository.clearCachedDataIfNeeded()
    }
    
    public override func loadItems() throws -> Future<[Contact], Error> {
        return contactRepository.fetchAllContacts()
    }
    
    public override func loadItems(params: [String: Any]?) throws -> Future<[Contact], Error> {
        return contactRepository.fetchContacts(size: 10)
    }
}


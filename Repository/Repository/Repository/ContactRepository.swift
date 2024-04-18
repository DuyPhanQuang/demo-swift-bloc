//
//  ContactRepository.swift
//  Repository
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import Combine

public protocol ContactRepository {
    func clearCachedDataIfNeeded()
    
    func fetchAllContacts() -> Future<[Contact], Error>
    
    func fetchContacts(size: Int) -> Future<[Contact], Error>
    
    func editContact(contact: Contact) -> Future<Contact, Error>
}

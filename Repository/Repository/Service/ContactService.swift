//
//  ContactService.swift
//  Repository
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import Combine

public protocol ContactService {
    func fetchContacts(withSize size: Int) -> AnyPublisher<[Contact], Error>
    func editContact(contact: Contact) -> AnyPublisher<[Contact], Error>?
}

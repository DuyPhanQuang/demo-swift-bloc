//
//  ContactInteractor.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import Combine
import Repository

public protocol ContactInteractor {
    func editContactById(contact: Contact) -> Future<Contact, Error>
}

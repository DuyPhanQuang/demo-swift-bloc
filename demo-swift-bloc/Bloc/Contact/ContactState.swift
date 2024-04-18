//
//  ContactState.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Repository

public class ContactState: State {
    public let contact: Contact
    public init(contact: Contact) {
        self.contact = contact
    }
    
    static public func == (lhs: ContactState, rhs: ContactState) -> Bool {
        return lhs.contact == rhs.contact
    }
}

public class ContactInitial: ContactState {}

public class ContactEditInProgress: ContactState {}

public class ContactEditSuccess: ContactState {}

public class ContactEditFailure: ContactState {}


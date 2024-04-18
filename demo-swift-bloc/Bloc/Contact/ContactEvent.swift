//
//  ContactEvent.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Repository

public class ContactEvent: Event {}

public class ContactEdited: ContactEvent {
    var contact: Contact
    public init(contact: Contact) {
        self.contact = contact
    }
}


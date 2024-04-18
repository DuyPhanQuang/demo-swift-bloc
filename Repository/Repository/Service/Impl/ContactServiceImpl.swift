//
//  ContactServiceImpl.swift
//  Repository
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import Combine

public class ContactServiceImpl: BaseService, ContactService {
    
    public init(baseUrl: BaseUrl, urlSession: URLSession = URLSession.shared) {
        super.init(baseUrl, urlSession: urlSession)
    }
    
    public func fetchContacts(withSize size: Int = 10) -> AnyPublisher<[Contact], Error> {
        return get(path: .fetchContacts(size: 10))
            .map { json -> [Contact] in
                let list = json["results"] as! [Dictionary<String, Any>]
                let contacts = list.map { Contact(dictionary: $0) }
                return contacts
            }
            .eraseToAnyPublisher()
    }
    
    public func editContact(contact: Contact) -> AnyPublisher<[Contact], Error>? {
        return nil
    }
}


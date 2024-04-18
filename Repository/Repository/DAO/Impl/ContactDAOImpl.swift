//
//  ContactDAOImpl.swift
//  Repository
//
//  Created by duy.phan on 18/4/24.
//

import Foundation

public class ContactDAOImpl: BaseDAO<Contact>, ContactDAO {
    public init(userDefaults: UserDefaults = UserDefaults.standard, expiredTimeInMinute: Int? = nil) {
        super.init(userDefaults, expiredTimeInMinute: expiredTimeInMinute)
    }
    
    public func getCachedContacts() -> [Contact]? {
        return self.getItems(key: RepositoryContactDAOConfigsKey.contact.rawValue)
    }
    
    public func saveContacts(contacts: [Contact]) {
        cachedItems(items: contacts, key: RepositoryContactDAOConfigsKey.contact.rawValue)
    }
    
    public func clearCachedContacts() {
        clearCached(key: RepositoryContactDAOConfigsKey.contact.rawValue)
    }
}


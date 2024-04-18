//
//  ContactDAO.swift
//  Repository
//
//  Created by duy.phan on 18/4/24.
//

import Foundation


public protocol ContactDAO {
    func clearCachedContacts()
    
    func getCachedContacts() -> [Contact]?
    
    func saveContacts(contacts: [Contact])
}

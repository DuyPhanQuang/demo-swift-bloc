//
//  ContactRepositoryImpl.swift
//  Repository
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import Combine

public class ContactRepositoryImpl: ContactRepository {
    
    private var contactDAO: ContactDAO!
    private var contactService: ContactService!
    private var disposables = Set<AnyCancellable>()
    
    public init(contactDAO: ContactDAO, contactService: ContactService) {
        self.contactService = contactService
        self.contactDAO = contactDAO
    }
    
    public func clearCachedDataIfNeeded() {
        self.contactDAO.clearCachedContacts()
    }
    
    public func fetchAllContacts() -> Future<[Contact], Error> {
        return fetchContacts(size: 100)
    }
    
    public func fetchContacts(size: Int) -> Future<[Contact], Error> {
        return Future { [weak self] promise in
            guard let self = self else {
                promise(.success([Contact]()))
                return
            }
            if let cached = self.contactDAO.getCachedContacts() {
                promise(.success(cached))
                return
            }
            
            self.contactService.fetchContacts(withSize: size)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { items in
                    self.contactDAO.saveContacts(contacts: items)
                    promise(.success(items))
                })
                .store(in: &self.disposables)
        }
    }
    
    public func editContact(contact: Contact) -> Future<Contact, Error> {
        return Future { promise in
            if (contact.id == "bug") {
                promise(.failure(APIError.unknown))
                return
            }
            promise(.success(contact))
        }
    }
}

//
//  Repository.swift
//  Repository
//
//  Created by duy.phan on 18/4/24.
//

import Foundation

public class Repositories {
    public static let shared = Repositories()
    
    private let baseUrl: BaseUrl
    
    init() {
        self.baseUrl =  BaseUrl(apiEndpointUrl: RepositoryConfigs.shared.apiEndpointUrl)
    }
    
    // Api services
    func contactService() -> ContactService {
        return ContactServiceImpl(baseUrl: baseUrl)
    }
    
    // DAO
    func contactDAO() -> ContactDAO {
        return ContactDAOImpl()
    }
    
    // Repository
    public func contactRepository() -> ContactRepository {
        return ContactRepositoryImpl(contactDAO: contactDAO(), contactService: contactService())
    }
}

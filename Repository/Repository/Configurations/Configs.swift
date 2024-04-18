//
//  Configs.swift
//  Repository
//
//  Created by duy.phan on 18/4/24.
//

import Foundation

enum RepositoryDAOConfigsKey: String {
    case lastUpdated = "key.lastUpdated"
}

enum RepositoryContactDAOConfigsKey: String {
    case contact = "key.contacts"
}

enum ConfigsKey: String {
    case apiEndpointUrl = "apiEndpointUrl"
}

public class RepositoryConfigs {
    static let shared = RepositoryConfigs()
    
    var apiEndpointUrl: String {
        return Bundle.main.readStringFromConfig(key: .apiEndpointUrl)
    }
}

// MARK: - Extension on bundle to read config variable
extension Bundle {

    /// Read one variable from the bundle plist file
    ///
    /// - Parameter key: the config to read
    /// - Returns: the value from config file
    func readStringFromConfig(key: ConfigsKey) -> String {
        return Bundle.main.object(forInfoDictionaryKey: key.rawValue) as! String
    }
}





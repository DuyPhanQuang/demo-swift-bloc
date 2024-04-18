//
//  BaseDAO.swift
//  Repository
//
//  Created by duy.phan on 18/4/24.
//

import Foundation

public class BaseDAO<T: Codable> {
    private var userDefaults: UserDefaults
    private var expiredTimeInMinute: Int?
    
    public init(_ userDefaults: UserDefaults, expiredTimeInMinute: Int? = nil) {
        self.userDefaults = userDefaults
        self.expiredTimeInMinute = expiredTimeInMinute
    }
    
    public func cachedItems(items: [T], key: String, now: Date = Date()) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            userDefaults.setValue(encoded, forKey: key)
            userDefaults.setValue(Date(), forKey: RepositoryDAOConfigsKey.lastUpdated.rawValue)
        }
    }
    
    public func getItems(key: String, now: Date = Date()) -> [T]? {
        if let data = userDefaults.data(forKey: key) {
            if let lastUpdated = userDefaults.object(forKey: RepositoryDAOConfigsKey.lastUpdated.rawValue) as? Date, let expiredTime = expiredTimeInMinute {
                if let minute = Calendar.current.dateComponents([.minute], from: lastUpdated, to: now).minute, minute > expiredTime {
                    return nil
                }
            }
            let decoder = JSONDecoder()
            if let items = try? decoder.decode([T].self, from: data) {
                return items
            }
        }
        return nil
    }
    
    public func clearCached(key: String) {
        userDefaults.removeObject(forKey: key)
        userDefaults.removeObject(forKey: RepositoryDAOConfigsKey.lastUpdated.rawValue)
    }
}


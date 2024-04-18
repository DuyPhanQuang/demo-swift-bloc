//
//  ContactExtension.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Repository

extension Contact {
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    func age() -> Int {
        return birthday?.age() ?? 0
    }
    
    func fullAddress() -> String {
        return "\(street), \(city), \(state), \(country)"
    }
}


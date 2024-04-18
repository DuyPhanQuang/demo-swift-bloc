//
//  Keys.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation

class Keys {
    
    class Bloc {
        // common
        static let loadingBloc = "loading_bloc_key"
        
        // list
        static let contactList = "contact_list_bloc_key"
        
        // single with key
        static func contactBlocById(id: String) -> String {
            return "contact_bloc_key_\(id)"
        }
    }
}


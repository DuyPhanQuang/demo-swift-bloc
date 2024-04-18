//
//  LoadListEvent.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation

class LoadListEvent: Event {
    var params: [String: Any]?
    
    init(params: [String: Any]? = nil) {
        self.params = params
    }
}

class LoadListStarted: LoadListEvent {}

class LoadListNextPageStarted: LoadListEvent {}

class LoadListRefreshed: LoadListEvent {}

class LoadListReloaded<T: Equatable>: LoadListEvent {
    var items: [T]?
    init(items: [T]? = nil) {
        self.items = items
    }
}


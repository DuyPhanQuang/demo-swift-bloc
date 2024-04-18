//
//  LoadListInteractor.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import Combine

public class LoadListInteractor<T: Equatable> {
    func forceToRefresh() { }
    
    func shoudReloadData() {}
    
    func shouldRefresh() {}
    
    public func loadItems() throws -> Future<[T], Error> { fatalError("not implemented yet") }
    
    public func loadItems(params: [String: Any]?) throws -> Future<[T], Error> { fatalError("not implemented yet") }
}

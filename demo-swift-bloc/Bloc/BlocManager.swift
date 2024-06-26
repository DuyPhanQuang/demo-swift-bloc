//
//  BlocManager.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import SwiftBloc

class BlocManager {
    static let shared = BlocManager()
    
    private var blocs = NSMapTable<NSString, AnyObject>.init(
        keyOptions: .copyIn,
        valueOptions: .weakMemory
    )
    
    private let disposingQueue = DispatchQueue(label: "disposing.queue")
    private var dependentBlocs = [String: [Any]]()
    
    func newBloc<B: BaseBloc<E, S>, E: Event, S: State>(key: String,  constructor: @escaping () -> B) -> B {
         print("BLOCS = \(blocs)")
        if let blocFound = blocs.object(forKey: key as NSString) as? B {
            return blocFound
        }
        
        let newInstance = constructor()
        blocs.setObject(newInstance, forKey: key as NSString)
        
        if let closeWithKey = newInstance.closeWithBlocKey {
            if var existed = dependentBlocs[closeWithKey] {
                existed.append(newInstance)
            } else {
                dependentBlocs[closeWithKey] = [newInstance]
            }
        }
         print("UPDATED BLOCS = \(blocs)")
        
        return newInstance
    }
    
    func blocByKey<B: BaseBloc<E, S>, E: Event, S: State>(key: String) -> B? {
        if let blocFound = blocs.object(forKey: key as NSString) as? B {
            return blocFound
        }
        return nil
    }
    
    func event<B: BaseBloc<E, S>, E: Event, S: State>(_ type: B.Type, key: String, event: E) {
        if let blocFound = blocs.object(forKey: key as NSString) as? B {
            print("BLOC EVENT = \(event)")
            blocFound.add(event: event)
        }
    }
    
    func disposeBloc(key: String) {
        disposingQueue.async { [unowned self] in
             print("DEPENDENT BLOC = \(self.dependentBlocs)")
            if let _ = self.dependentBlocs[key] {
                self.dependentBlocs[key] = nil
            }
        }
    }
}

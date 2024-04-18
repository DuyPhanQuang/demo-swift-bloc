//
//  Configs.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation

final class Configs {
    static let shared = Configs()
    
    var isStorybook: Bool
    
    init() {
        isStorybook = AppEnvironment.isStorybook
    }
}

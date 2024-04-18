//
//  LazyView.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

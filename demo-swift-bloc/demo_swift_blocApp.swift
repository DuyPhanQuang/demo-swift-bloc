//
//  demo_swift_blocApp.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation

import SwiftUI

@main
struct demo_swift_blocApp: App {
    var body: some Scene {
        WindowGroup {
            AppShowingView()
                .provideBloc(create: { BlocConstructors().loadingBloc() })
        }
    }
}

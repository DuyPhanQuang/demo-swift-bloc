//
//  AppShowingView.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import SwiftUI
import SwiftBloc

struct AppShowingView: View {
    @EnvironmentObject private var bloc: LoadingBloc
    let router = NavigationRouter(routes: .all)
    
    var body: some View {
        BlocView(builder: { bloc in
            NavigationView {
                RouterView(
                    router: router,
                    root: Configs.shared.isStorybook ? .storyBook : .splash
                )
            }
            .environment(\.router, router)
            .navigationViewStyle(StackNavigationViewStyle())
            .if(bloc.state.isLoading) { view in
                view.overlay(LoadingOverlay())
            }
        }, base: bloc)
    }
}

struct AppShowingView_Previews: PreviewProvider {
    static var previews: some View {
        AppShowingView()
    }
}


//
//  LoadingBloc.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation
import SwiftBloc

public class LoadingBloc: BaseBloc<LoadingEvent, LoadingState> {
    public init(key: String) {
        super.init(
            key: key,
            inititalState: LoadingInitial()
        )
        
        onEvent(LoadingShowed.self, handler: { event, emitter in
            emitter.send(LoadingUpdated(loading: true))
        })
        
        onEvent(LoadingHide.self, handler: { event, emitter in
            emitter.send(LoadingUpdated(loading: false))
        })
    }
}

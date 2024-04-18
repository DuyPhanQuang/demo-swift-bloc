//
//  SpacerView.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import SwiftUI

struct SpacerView: View {
    var width: CGFloat = 1
    var height: CGFloat = 1
    
    var body: some View {
        Rectangle().fill(Color.clear)
            .frame(width: width, height: height)
    }
}

//
//  SwiftUIView.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import SwiftUI
import Kingfisher

struct AvatarView: View {
    var avatar: String
    var size: CGFloat
    
    var body: some View {
        ZStack {
            KFImage.url(URL(string: avatar)!)
                .placeholder { Image("avatar_placeholder").resizable() }
                .fade(duration: 0.5)
                .resizing(referenceSize: CGSize(width: size, height: size), mode: .aspectFit)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        }
        .frame(width: size, height: size, alignment: .center)
    }
}

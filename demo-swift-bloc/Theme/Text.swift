//
//  Text.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import SwiftUI

extension Text {
    public func primaryRegular(fontSize: CGFloat =  13, color: Color = Color.primaryTextColor) -> Text {
        return self.font(
                .custom(DesignTokens.fontFamilyPrimary, size: fontSize)
            )
            .foregroundColor(color)
    }
    
    public func primaryBold(fontSize: CGFloat =  13, color: Color = Color.primaryTextColor) -> Text {
        return self.primaryRegular(fontSize: fontSize, color: color)
            .fontWeight(.bold)
    }
    
    public func secondaryRegular(fontSize: CGFloat =  13, color: Color = Color.primaryTextColor) -> Text {
        return self.font(
                .custom(DesignTokens.fontFamilySecondary, size: fontSize)
            )
            .foregroundColor(color)
    }
}

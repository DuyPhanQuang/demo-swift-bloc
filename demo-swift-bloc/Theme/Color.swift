//
//  Color.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import UIKit
import SwiftUI

extension UIColor {
    public func color() -> Color {
        return Color(self)
    }
}

extension Color {
    public static var primaryButtonColor: Color {
        return DesignTokens.colorBaseOrange.color()
    }
    
    public static var primaryHighlightColor: Color {
        return DesignTokens.colorBaseRed.color()
    }
    
    public static var primaryDisableColor: Color {
        return DesignTokens.colorBaseGrayLight.color()
    }
    
    public static var primaryTextColor: Color {
        return DesignTokens.colorBaseGrayDark.color()
    }
    
    public static var borderButtonColor: Color {
        return DesignTokens.colorBaseGrayDark.color()
    }
    
    public static var secondaryButtonColor: Color {
        return DesignTokens.colorBaseGrayLight.color()
    }
}

//
// SwiftUI+Font-Functions.swift
// PVCWindowsGenerator
//
// Autogenerated by the python script
//

import SwiftUI


extension Font {
    static func custom(_ type: FontType, size: CGFloat) -> Font {
        return .custom(type.rawValue, size: size)
    }

    static func custom(_ type: FontType, size: FontSize) -> Font {
        return .custom(type, size: size.rawValue)
    }


    // Convenience static funcs
    
    static func rubikMediumItalic(_ size: CGFloat) -> Font { return .custom(.rubikMediumItalic, size: size) }
    static func rubikMediumItalic(_ size: FontSize) -> Font { return .rubikMediumItalic(size.rawValue) }

    static func rubikBold(_ size: CGFloat) -> Font { return .custom(.rubikBold, size: size) }
    static func rubikBold(_ size: FontSize) -> Font { return .rubikBold(size.rawValue) }

    static func rubikSemiBoldItalic(_ size: CGFloat) -> Font { return .custom(.rubikSemiBoldItalic, size: size) }
    static func rubikSemiBoldItalic(_ size: FontSize) -> Font { return .rubikSemiBoldItalic(size.rawValue) }

    static func rubikLight(_ size: CGFloat) -> Font { return .custom(.rubikLight, size: size) }
    static func rubikLight(_ size: FontSize) -> Font { return .rubikLight(size.rawValue) }

    static func rubikMedium(_ size: CGFloat) -> Font { return .custom(.rubikMedium, size: size) }
    static func rubikMedium(_ size: FontSize) -> Font { return .rubikMedium(size.rawValue) }

    static func rubikExtraBoldItalic(_ size: CGFloat) -> Font { return .custom(.rubikExtraBoldItalic, size: size) }
    static func rubikExtraBoldItalic(_ size: FontSize) -> Font { return .rubikExtraBoldItalic(size.rawValue) }

    static func rubikBlack(_ size: CGFloat) -> Font { return .custom(.rubikBlack, size: size) }
    static func rubikBlack(_ size: FontSize) -> Font { return .rubikBlack(size.rawValue) }

    static func rubikItalic(_ size: CGFloat) -> Font { return .custom(.rubikItalic, size: size) }
    static func rubikItalic(_ size: FontSize) -> Font { return .rubikItalic(size.rawValue) }

    static func rubikLightItalic(_ size: CGFloat) -> Font { return .custom(.rubikLightItalic, size: size) }
    static func rubikLightItalic(_ size: FontSize) -> Font { return .rubikLightItalic(size.rawValue) }

    static func rubikSemiBold(_ size: CGFloat) -> Font { return .custom(.rubikSemiBold, size: size) }
    static func rubikSemiBold(_ size: FontSize) -> Font { return .rubikSemiBold(size.rawValue) }

    static func rubikBlackItalic(_ size: CGFloat) -> Font { return .custom(.rubikBlackItalic, size: size) }
    static func rubikBlackItalic(_ size: FontSize) -> Font { return .rubikBlackItalic(size.rawValue) }

    static func rubikExtraBold(_ size: CGFloat) -> Font { return .custom(.rubikExtraBold, size: size) }
    static func rubikExtraBold(_ size: FontSize) -> Font { return .rubikExtraBold(size.rawValue) }

    static func rubikRegular(_ size: CGFloat) -> Font { return .custom(.rubikRegular, size: size) }
    static func rubikRegular(_ size: FontSize) -> Font { return .rubikRegular(size.rawValue) }

    static func rubikBoldItalic(_ size: CGFloat) -> Font { return .custom(.rubikBoldItalic, size: size) }
    static func rubikBoldItalic(_ size: FontSize) -> Font { return .rubikBoldItalic(size.rawValue) }
}
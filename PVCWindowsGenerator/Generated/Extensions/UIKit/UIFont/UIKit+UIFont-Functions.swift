//
// UIKit+UIFont-Functions.swift
// PVCWindowsGenerator
//
// Autogenerated by the python script
//

import UIKit


extension UIFont {
    static func custom(_ type: FontType, size: CGFloat) -> UIFont {
        return self.init(name: type.rawValue, size: size)
            ?? .systemFont(ofSize: size, weight: .medium)
    }

    static func custom(_ type: FontType, size: FontSize) -> UIFont {
        return .custom(type, size: size.rawValue)
    }


    // Convenience static funcs
    
    static func rubikMediumItalic(_ size: CGFloat) -> UIFont { return .custom(.rubikMediumItalic, size: size) }
    static func rubikMediumItalic(_ size: FontSize) -> UIFont { return .rubikMediumItalic(size.rawValue) }

    static func rubikBold(_ size: CGFloat) -> UIFont { return .custom(.rubikBold, size: size) }
    static func rubikBold(_ size: FontSize) -> UIFont { return .rubikBold(size.rawValue) }

    static func rubikSemiBoldItalic(_ size: CGFloat) -> UIFont { return .custom(.rubikSemiBoldItalic, size: size) }
    static func rubikSemiBoldItalic(_ size: FontSize) -> UIFont { return .rubikSemiBoldItalic(size.rawValue) }

    static func rubikLight(_ size: CGFloat) -> UIFont { return .custom(.rubikLight, size: size) }
    static func rubikLight(_ size: FontSize) -> UIFont { return .rubikLight(size.rawValue) }

    static func rubikMedium(_ size: CGFloat) -> UIFont { return .custom(.rubikMedium, size: size) }
    static func rubikMedium(_ size: FontSize) -> UIFont { return .rubikMedium(size.rawValue) }

    static func rubikExtraBoldItalic(_ size: CGFloat) -> UIFont { return .custom(.rubikExtraBoldItalic, size: size) }
    static func rubikExtraBoldItalic(_ size: FontSize) -> UIFont { return .rubikExtraBoldItalic(size.rawValue) }

    static func rubikBlack(_ size: CGFloat) -> UIFont { return .custom(.rubikBlack, size: size) }
    static func rubikBlack(_ size: FontSize) -> UIFont { return .rubikBlack(size.rawValue) }

    static func rubikItalic(_ size: CGFloat) -> UIFont { return .custom(.rubikItalic, size: size) }
    static func rubikItalic(_ size: FontSize) -> UIFont { return .rubikItalic(size.rawValue) }

    static func rubikLightItalic(_ size: CGFloat) -> UIFont { return .custom(.rubikLightItalic, size: size) }
    static func rubikLightItalic(_ size: FontSize) -> UIFont { return .rubikLightItalic(size.rawValue) }

    static func rubikSemiBold(_ size: CGFloat) -> UIFont { return .custom(.rubikSemiBold, size: size) }
    static func rubikSemiBold(_ size: FontSize) -> UIFont { return .rubikSemiBold(size.rawValue) }

    static func rubikBlackItalic(_ size: CGFloat) -> UIFont { return .custom(.rubikBlackItalic, size: size) }
    static func rubikBlackItalic(_ size: FontSize) -> UIFont { return .rubikBlackItalic(size.rawValue) }

    static func rubikExtraBold(_ size: CGFloat) -> UIFont { return .custom(.rubikExtraBold, size: size) }
    static func rubikExtraBold(_ size: FontSize) -> UIFont { return .rubikExtraBold(size.rawValue) }

    static func rubikRegular(_ size: CGFloat) -> UIFont { return .custom(.rubikRegular, size: size) }
    static func rubikRegular(_ size: FontSize) -> UIFont { return .rubikRegular(size.rawValue) }

    static func rubikBoldItalic(_ size: CGFloat) -> UIFont { return .custom(.rubikBoldItalic, size: size) }
    static func rubikBoldItalic(_ size: FontSize) -> UIFont { return .rubikBoldItalic(size.rawValue) }
}

//
//  FontManager.swift
//  Codingdong-iOS
//
//  Created by BAE on 2023/10/18.
//

import UIKit

/// AX1 가이드라인 준수
enum FontSize: CGFloat {
    
    case largetitle = 44
    case title1 = 38
    case title2 = 34
    case title3 = 31
    case body = 28
    case textbutton = 27
    case callout = 26
    case subhead = 25
    case navigationtitle = 24
    case footnote = 23
    case caption1 = 22
    case caption2 = 20
    
}

/// Pretendard Static Fonts
enum PretendardType: String {
    
    case black = "Pretendard-Black"
    case bold = "Pretendard-Bold"
    case extrabold = "Pretendard-ExtraBold"
    case extralight = "Pretendard-ExtraLight"
    case light = "Pretendard-Light"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
    case semibold = "Pretendard-SemiBold"
    case thin = "Pretendard-Thin"
    
}

/// Pretendard Only
struct FontManager {
    
    static let shared = FontManager()
    
    /// type - pretendard type
    /// size - AX1 font size.
    func pretendard(_ type: PretendardType, _ size: FontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
    }
    
}

extension FontManager {
    
    static func p_Black(_ size: FontSize) -> UIFont {
        FontManager.shared.pretendard(.black, size)
    }
    
    static func p_Bold(_ size: FontSize) -> UIFont {
        FontManager.shared.pretendard(.bold, size)
    }
    
    static func p_ExBold(_ size: FontSize) -> UIFont {
        FontManager.shared.pretendard(.extrabold, size)
    }
    
    static func p_ExLight(_ size: FontSize) -> UIFont {
        FontManager.shared.pretendard(.extralight, size)
    }
    
    static func p_Light(_ size: FontSize) -> UIFont {
        FontManager.shared.pretendard(.light, size)
    }
    
    static func p_Medium(_ size: FontSize) -> UIFont {
        FontManager.shared.pretendard(.medium, size)
    }
    
    static func p_Regular(_ size: FontSize) -> UIFont {
        FontManager.shared.pretendard(.regular, size)
    }
    
    static func p_semiBold(_ size: FontSize) -> UIFont {
        FontManager.shared.pretendard(.semibold, size)
    }
    
    static func p_Thin(_ size: FontSize) -> UIFont {
        FontManager.shared.pretendard(.thin, size)
    }
    
    static func largeTitle() -> UIFont {
        FontManager.shared.pretendard(.regular, .largetitle)
    }
    
    static func title1() -> UIFont {
        FontManager.shared.pretendard(.regular, .title1)
    }
    
    static func title2() -> UIFont {
        FontManager.shared.pretendard(.regular, .title2)
    }
    
    static func title3() -> UIFont {
        FontManager.shared.pretendard(.regular, .title3)
    }
    
    static func body() -> UIFont {
        FontManager.shared.pretendard(.regular, .body)
    }
    
    static func textbutton() -> UIFont {
        FontManager.shared.pretendard(.semibold, .textbutton)
    }
    
    static func callout() -> UIFont {
        FontManager.shared.pretendard(.regular, .callout)
    }
    
    static func subhead() -> UIFont {
        FontManager.shared.pretendard(.semibold, .subhead)
    }
    
    static func navigationtitle() -> UIFont {
        FontManager.shared.pretendard(.semibold, .navigationtitle)
    }
    
    static func footnote() -> UIFont {
        FontManager.shared.pretendard(.regular, .footnote)
    }
    
    static func caption1() -> UIFont {
        FontManager.shared.pretendard(.regular, .caption1)
    }
    
    static func caption2() -> UIFont {
        FontManager.shared.pretendard(.regular, .caption2)
    }
    
    static func headline() -> UIFont {
        FontManager.shared.pretendard(.semibold, .body)
    }
    
}

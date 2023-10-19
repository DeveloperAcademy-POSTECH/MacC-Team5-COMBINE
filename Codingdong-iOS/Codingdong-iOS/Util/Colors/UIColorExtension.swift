//
//  UIColorExtension.swift
//  Codingdong-iOS
//
//  Created by 이승용 on 10/17/23.
//

import UIKit

extension UIColor {

    // MARK: Primary Color
    /// #373DCC
    static let PrimaryColor1 = UIColor.init(hex: "#373DCC")
    /// #CDCFFF
    static let PrimaryColor2 = UIColor.init(hex: "#CDCFFF")
    
    // MARK: Secondary Color
    /// #FFD640
    static let SecondaryColor1 = UIColor.init(hex: "#FFD640")
    /// #FFEFB2
    static let SecondaryColor2 = UIColor.init(hex: "#FFEFB2")
    
    // MARK: Grayscale Colors
    /// #F4F4F4
    static let GrayScale10 = UIColor.init(hex: "#F4F4F4")
    /// #C6C6C6
    static let GrayScale20 = UIColor.init(hex: "#C6C6C6")
    /// #AEAEB2
    static let GrayScale30 = UIColor.init(hex: "#AEAEB2")
    /// #8E8E93
    static let GrayScale40 = UIColor.init(hex: "#8E8E93")
    /// #636366
    static let GrayScale50 = UIColor.init(hex: "#636366")
    /// #48484A
    static let GrayScale60 = UIColor.init(hex: "#48484A")
    /// #363639
    static let GrayScale70 = UIColor.init(hex: "#363639")
    /// #2C2C2E
    static let GrayScale80 = UIColor.init(hex: "#2C2C2E")
    /// #1C1C1E
    static let GrayScale90 = UIColor.init(hex: "#1C1C1E")
    
    // MARK: 기타 컬러 HEX값으로 추출
    convenience init(hex: String) {
        let scanner = Scanner(string: hex) // 문자 파서역할을 하는 클래스
        _ = scanner.scanString("#")  // scanString은 iOS13 부터 지원
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1)
    }
}

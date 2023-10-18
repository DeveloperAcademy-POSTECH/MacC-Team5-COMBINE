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
    static let PrimaryColor1 = UIColor.init(netHex: 0x373DCC)
    /// #CDCFFF
    static let PrimaryColor2 = UIColor.init(netHex: 0xCDCFFF)
    
    // MARK: Secondary Color
    /// #FFD640
    static let SecondaryColor1 = UIColor.init(netHex: 0xFFD640)
    /// #FFEFB2
    static let SecondaryColor2 = UIColor.init(netHex: 0xFFEFB2)
    
    // MARK: Grayscale Colors
    /// #F4F4F4
    static let GrayScale10 = UIColor.init(netHex: 0xF4F4F4)
    /// #C6C6C6
    static let GrayScale20 = UIColor.init(netHex: 0xC6C6C6)
    /// #AEAEB2
    static let GrayScale30 = UIColor.init(netHex: 0xAEAEB2)
    /// #8E8E93
    static let GrayScale40 = UIColor.init(netHex: 0x8E8E93)
    /// #636366
    static let GrayScale50 = UIColor.init(netHex: 0x636366)
    /// #48484A
    static let GrayScale60 = UIColor.init(netHex: 0x48484A)
    /// #363639
    static let GrayScale70 = UIColor.init(netHex: 0x363639)
    /// #2C2C2E
    static let GrayScale80 = UIColor.init(netHex: 0x2C2C2E)
    /// #1C1C1E
    static let GrayScale90 = UIColor.init(netHex: 0x1C1C1E)
    
    // MARK: RGB값으로 색상 지정
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    // MARK: HEX값으로 색상 지정
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

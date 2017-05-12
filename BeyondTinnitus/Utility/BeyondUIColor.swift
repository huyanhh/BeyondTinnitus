//
//  BeyondUIColor.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit

extension UIColor {
    class func colorWithRGBHex(hex: UInt32) -> UIColor {
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
        let g = CGFloat((hex >> 8) & 0xFF) / 255.0
        let b = CGFloat(hex & 0xFF) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    class func colorFromHexString(str: String) -> UIColor {
        var s = str
        if s.hasPrefix("#") { s = s.substring(from: s.index(after: s.startIndex)) }
        let scanner = Scanner(string: s)
        var hexnum: UInt32 = 0
        if scanner.scanHexInt32(&hexnum) { return UIColor.colorWithRGBHex(hex: hexnum) }
        fatalError()
    }
    
    enum Beyond: String {
        case teal   = "00D8C5" //Robin Egg Blue
        case babyBlue = "75FFFF"
    }
    
    class func beyond(color: Beyond) -> UIColor { return colorFromHexString(str: color.rawValue) }
}

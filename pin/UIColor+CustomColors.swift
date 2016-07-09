//
//  UIColor+CustomColors.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import Swift
import UIKit

extension UIColor {
    class func fromRgbHex(fromHex: Int) -> UIColor {
        
        let red = CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue = CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func deepOrange() -> UIColor {
        let deepOrange = 0xE64A19
        return UIColor.fromRgbHex(deepOrange)
    }
    
    class func orange() -> UIColor {
        let orange = 0xFF5722
        return UIColor.fromRgbHex(orange)
    }
    
    class func lightOrange() -> UIColor {
        let lightOrange = 0xFFCCBC
        return UIColor.fromRgbHex(lightOrange)
    }
    
    class func cyan() -> UIColor {
        let cyan = 0x00BCD4
        return UIColor.fromRgbHex(cyan)
    }
    
    class func darkGray() -> UIColor {
        let darkGray = 0x727272
        return UIColor.fromRgbHex(darkGray)
    }
}

//
//  UIColor+Hex.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

import UIKit

extension UIColor {

    public convenience init(hexString: String) {
        let hexString: NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        let scanner            = Scanner(string: hexString as String)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask  = 0x000000FF
        let red   = Int(color >> 16) & mask
        let green = Int(color >> 8) & mask
        let blue  = Int(color) & mask

        let red1   = CGFloat(red) / 255.0
        let green1 = CGFloat(green) / 255.0
        let blue1  = CGFloat(blue) / 255.0

        self.init(red: red1, green: green1, blue: blue1, alpha: 1)
    }

    public func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0

        return NSString(format: "#%06x", rgb) as String
    }
 
    public convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            self.init(red: 1, green: 1, blue: 1)
            return
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        self.init(
            red: Int((rgbValue & 0xFF0000) >> 16),
            green: Int((rgbValue & 0x00FF00) >> 8),
            blue: Int(rgbValue & 0x0000FF),
            alpha: alpha
        )
    }

    public convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    public convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }

}

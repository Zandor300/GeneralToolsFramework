//
//  UIColor+Lerp.swift
//  Connectivity
//
//  Created by Zandor Smith on 20/02/2019.
//

#if os(iOS) || os(tvOS)
import Foundation

extension UIColor {

    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        guard let components = self.cgColor.components else { return nil }
        return (
            red: components[0],
            green: components[1],
            blue: components[2],
            alpha: components[3]
        )
    }

    public static func lerp(startColor: UIColor, endColor: UIColor, position: CGFloat) -> UIColor {
        let compontents1 = startColor.colorComponents!
        let compontents2 = endColor.colorComponents!

        let red: CGFloat = compontents1.red * (1 - position) + compontents2.red * position
        let green: CGFloat = compontents1.green * (1 - position) + compontents2.green * position
        let blue: CGFloat = compontents1.blue * (1 - position) + compontents2.blue * position
        let alpha: CGFloat = compontents1.alpha * (1 - position) + compontents2.alpha * position

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}
#endif

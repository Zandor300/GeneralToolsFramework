//
//  UIFont+DynamicType.swift
//  Connectivity
//
//  Created by Zandor Smith on 14/10/2019.
//

import UIKit

extension UIFont {

    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        if #available(iOS 11.0, *) {
            let metrics = UIFontMetrics(forTextStyle: style)
            let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
            let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
            return metrics.scaledFont(for: font)
        } else {
            return UIFont.preferredFont(forTextStyle: style)
        }
    }

    func scaled(for style: TextStyle) -> UIFont {
        if #available(iOS 11.0, *) {
            let metrics = UIFontMetrics(forTextStyle: style)
            return metrics.scaledFont(for: self)
        } else {
            return self
        }
    }

}

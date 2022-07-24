//
//  UIAccessibility+ButtonShapes.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 01/02/2019.
//

#if os(iOS)
import UIKit

public extension UIAccessibility {

    static var isButtonShapesEnabled: Bool {
        let button = UIButton()
        button.setTitle("Button Shapes", for: .normal)
        return button.titleLabel?.attributedText?.attribute(NSAttributedString.Key.underlineStyle, at: 0, effectiveRange: nil) != nil
    }

}
#endif

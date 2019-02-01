//
//  UIAccessibility+ButtonShapes.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 01/02/2019.
//

import UIKit

public extension UIAccessibility {
    
    public var isButtonShapesEnabled: Bool {
        let button = UIButton()
        button.setTitle("Button Shapes", for: .normal)
        return button.titleLabel?.attributedText?.attribute(NSAttributedString.Key.underlineStyle, at: 0, effectiveRange: nil) != nil
    }
    
}

//
//  UINavigationBar+LargeTitleHeight.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 13/02/2019.
//

import UIKit

extension UINavigationBar {
    
    public var largeTitleHeight: CGFloat {
        let maxSize = self.subviews
            .filter { $0.frame.origin.y > 0 }
            .max { $0.frame.origin.y < $1.frame.origin.y }
            .map { $0.frame.size }
        return maxSize?.height ?? 0
    }
    
}

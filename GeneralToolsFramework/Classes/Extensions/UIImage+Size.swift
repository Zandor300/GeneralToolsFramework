//
//  UIImage+Size.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 13/02/2019.
//

import UIKit

extension UIImage {
    
    public func getWidth(for height: Int) -> CGSize {
        let width = Float(self.size.width) / Float(self.size.height) * Float(height)
        return CGSize(width: Int(width.rounded()), height: height)
    }
    
    public func getHeight(for width: Int) -> CGSize {
        let height = Float(self.size.height) / Float(self.size.width) * Float(width)
        return CGSize(width: width, height: Int(height.rounded()))
    }
    
}

//
//  UIBlueButton.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

import UIKit

public class UIBlueButton : UIRoundedButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override func setupLayout() {
        super.setupLayout()
        applyGradient(colors: [
            UIColor(red: 41, green: 145, blue: 254, alpha: 1).cgColor,
            UIColor(red: 9, green: 121, blue: 254, alpha: 1).cgColor
        ])
    }
    
    func applyGradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.addSublayer(gradientLayer)
    }
    
}

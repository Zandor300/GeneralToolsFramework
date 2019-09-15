//
//  UIGradientButton.swift
//  Connectivity
//
//  Created by Zandor Smith on 15/09/2019.
//

import UIKit

open class UIGradientButton: UIRoundedButton {

    let tintColorTop: UIColor
    let tintColorBottom: UIColor

    let gradientLayer = CAGradientLayer()

    override public var bounds: CGRect {
        didSet {
            self.updateGradientFrame()
        }
    }

    init(frame: CGRect, tintColorTop: UIColor, tintColorBottom: UIColor) {
        self.tintColorTop = tintColorTop
        self.tintColorBottom = tintColorBottom
        super.init(frame: frame)
        self.setupLayout()
    }

    public init?(coder aDecoder: NSCoder, tintColorTop: UIColor, tintColorBottom: UIColor) {
        self.tintColorTop = tintColorTop
        self.tintColorBottom = tintColorBottom
        super.init(coder: aDecoder)
        self.setupLayout()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func setupLayout() {
        super.setupLayout()
        self.applyGradient(colors: [
            self.tintColorTop.cgColor,
            self.tintColorBottom.cgColor
        ])
    }

    func applyGradient(colors: [CGColor]) {
        self.gradientLayer.colors = colors
        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        self.gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.updateGradientFrame()
        self.gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.addSublayer(self.gradientLayer)
    }

    func updateGradientFrame() {
        self.gradientLayer.frame = self.bounds
    }

}

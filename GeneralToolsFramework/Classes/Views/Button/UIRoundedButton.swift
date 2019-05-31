//
//  UIRoundedButton.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

import UIKit

open class UIRoundedButton: UIButton {

    public static var defaultCornerRadius: CGFloat = 5

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    func setupLayout() {
        self.layer.cornerRadius = UIRoundedButton.defaultCornerRadius
    }

}

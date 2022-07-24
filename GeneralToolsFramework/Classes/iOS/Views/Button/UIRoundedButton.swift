//
//  UIRoundedButton.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

#if os(iOS) || os(tvOS)
import UIKit

open class UIRoundedButton: UIButton {

    public static var defaultCornerRadius: CGFloat = 5

    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupLayout()
    }

    open func setupLayout() {
        if self.cornerRadius == 0 {
            self.cornerRadius = UIRoundedButton.defaultCornerRadius
        }
    }

}
#endif

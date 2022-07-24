//
//  UIBlueButton.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

#if os(iOS)
import UIKit

public class UIBlueButton: UIGradientButton {

    init(frame: CGRect) {
        super.init(frame: frame, tintColorTop: UIColor(red: 41, green: 145, blue: 254, alpha: 1), tintColorBottom: UIColor(red: 9, green: 121, blue: 254, alpha: 1))
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, tintColorTop: UIColor(red: 41, green: 145, blue: 254, alpha: 1), tintColorBottom: UIColor(red: 9, green: 121, blue: 254, alpha: 1))
    }

}
#endif

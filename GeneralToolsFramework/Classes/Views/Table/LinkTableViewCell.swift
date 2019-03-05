//
//  LinkTableViewCell.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 12/02/2019.
//

import UIKit

public class LinkTableViewCell: UITableViewCell {

    public var linkColor: UIColor = UIColor.black {
        didSet {
            self.layoutSubviews()
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.tintColor = linkColor
        self.imageView?.tintColor = linkColor

        if UIAccessibility.isButtonShapesEnabled {
            let textRange = NSRange(location: 0, length: self.textLabel!.text!.count)
            let attributedText = NSMutableAttributedString(string: self.textLabel!.text!)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
            self.textLabel!.attributedText = attributedText
        }
    }

}

//
//  LinkTableViewCell.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 12/02/2019.
//

#if os(iOS)
import UIKit

public class LinkTableViewCell: UITableViewCell {

    public static var defaultLinkColor: UIColor = .systemBlue

    public var text: String? {
        get {
            return textLabel?.text
        }
        set {
            textLabel?.text = newValue
            self.layoutSubviews()
        }
    }
    public var linkColor: UIColor = LinkTableViewCell.defaultLinkColor {
        didSet {
            self.layoutSubviews()
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.tintColor = linkColor
        self.imageView?.tintColor = linkColor

        if UIAccessibility.isButtonShapesEnabled, let text = self.textLabel?.text {
            let textRange = NSRange(location: 0, length: text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
            self.textLabel?.attributedText = attributedText
        }
    }

}
#endif

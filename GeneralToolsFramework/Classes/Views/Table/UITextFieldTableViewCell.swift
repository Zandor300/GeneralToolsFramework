//
//  UITextFieldTableViewCell.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 31/12/2018.
//

import UIKit

public class UITextFieldTableViewCell: UITableViewCell {

    public var textField = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupTextField()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.textField.becomeFirstResponder()
        }
    }

    func setupTextField() {
        textField.textAlignment = .right
        textField.borderStyle = .none
        textField.frame = CGRect(x: 0, y: 0, width: 150, height: 20)

        self.selectionStyle = .none
        self.accessoryView = textField
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }

}

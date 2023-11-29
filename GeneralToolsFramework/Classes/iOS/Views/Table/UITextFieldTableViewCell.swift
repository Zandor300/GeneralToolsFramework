//
//  UITextFieldTableViewCell.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 31/12/2018.
//

#if os(iOS)
import UIKit

public class UITextFieldTableViewCell: UITableViewCell {

    public var textField = UITextField()
    public var selectAllOnBeginEditing: Bool = false

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextField()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.textField.becomeFirstResponder()
        }
    }

    func setupTextField() {
        textField.textAlignment = .right
        textField.borderStyle = .none
        textField.frame = CGRect(x: 0, y: 0, width: 150, height: 20)
        textField.delegate = self

        self.selectionStyle = .none
        self.accessoryView = textField
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }

}

extension UITextFieldTableViewCell: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard selectAllOnBeginEditing else {
            return
        }
        textField.perform(#selector(textField.selectAll(_:)), with: nil, afterDelay: 0.05)
    }

}
#endif

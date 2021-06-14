//
//  ZSPickerViewTableViewCell.swift
//  Connectivity
//
//  Created by Zandor Smith on 05/02/2020.
//

import UIKit
import AAPickerView

public class ZSPickerViewTableViewCell: UITableViewCell {

    public var pickerView = AAPickerView()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupTextField()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.pickerView.becomeFirstResponder()
        }
    }

    func setupTextField() {
        pickerView.textAlignment = .right
        pickerView.borderStyle = .none
        pickerView.frame = CGRect(x: 0, y: 0, width: 150, height: 20)

        self.selectionStyle = .none
        self.accessoryView = pickerView
    }

}

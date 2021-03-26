//
//  RedLinkTableViewCell.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 12/02/2019.
//

import UIKit

public class RedLinkTableViewCell: LinkTableViewCell {

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setColor()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setColor()
    }

    private func setColor() {
        self.linkColor = UIColor(red: 0.92, green: 0.16, blue: 0.14, alpha: 1.00)
    }

}

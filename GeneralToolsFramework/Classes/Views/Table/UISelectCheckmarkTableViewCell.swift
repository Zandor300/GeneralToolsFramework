//
//  UISelectCheckmarkTableViewCell.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 04/01/2019.
//

import UIKit

class UISelectCheckmarkTableViewCell: UITableViewCell {
    
    private var checked: Bool = false {
        didSet {
            if checked {
                self.accessoryType = .checkmark
            } else {
                self.accessoryType = .none
            }
        }
    }
    public var allowDeselect: Bool = false
    public var sectionIsGroup: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if allowDeselect {
                checked = !checked
            } else {
                checked = true
            }
            if checked && sectionIsGroup {
                let tableView = self.tableView
                if tableView == nil {
                    return
                }
                let indexPath = tableView!.indexPath(for: self)
                if indexPath == nil {
                    return
                }
                var targetIndexPath = IndexPath(row: 0, section: indexPath!.section)
                while let targetCell = tableView!.cellForRow(at: targetIndexPath) {
                    if targetCell != self {
                        (targetCell as? UISelectCheckmarkTableViewCell)?.checked = false
                    }
                    targetIndexPath = IndexPath(row: targetIndexPath.row + 1, section: indexPath!.section)
                }
            }
        }
    }
    
}

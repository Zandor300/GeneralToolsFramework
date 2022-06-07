//
//  UISelectCheckmarkTableViewCell.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 04/01/2019.
//

import UIKit

public class UISelectCheckmarkTableViewCell: UITableViewCell {

    var callbackOn: () -> (Bool) = {
        return true
    }
    var callbackOff: () -> (Bool) = {
        return true
    }

    public var checked: Bool = false {
        didSet {
            if checked {
                if !callbackOn() {
                    checked = false
                    self.updateCheckmark()
                    return
                }
                self.updateCheckmark()
                if sectionIsGroup {
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
                            let cell = targetCell as? UISelectCheckmarkTableViewCell
                            cell?.checked = false
                            cell?.updateCheckmark()
                        }
                        targetIndexPath = IndexPath(row: targetIndexPath.row + 1, section: indexPath!.section)
                    }
                }
            } else {
                if !callbackOff() {
                    checked = true
                    self.updateCheckmark()
                    return
                }
                self.updateCheckmark()
            }
        }
    }
    private var temporaryCallbackDisabled = false
    public var allowDeselect: Bool = false
    public var sectionIsGroup: Bool = false

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func updateCheckmark() {
        DispatchQueue.main.async {
            if self.checked {
                self.accessoryType = .checkmark
                print("Checkmark on " + (self.textLabel?.text ?? "unknown"))
            } else {
                self.accessoryType = .none
                print("No checkmark on " + (self.textLabel?.text ?? "unknown"))
            }
        }
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if allowDeselect {
                checked = !checked
            } else {
                checked = true
            }
        }
    }

    public func setStateOnCallback(callback: @escaping () -> (Bool)) {
        self.callbackOn = callback
    }

    public func setStateOffCallback(callback: @escaping () -> (Bool)) {
        self.callbackOff = callback
    }

}

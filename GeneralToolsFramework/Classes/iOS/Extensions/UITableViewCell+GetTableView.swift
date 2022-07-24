//
//  UITableViewCell+GetTableView.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 04/01/2019.
//

#if(iOS)
import UIKit

extension UITableViewCell {

    /// Get tableView this cell has been added to. Returns nil if it isn't assigned to a tableView.
    public var tableView: UITableView? {
        var view = self.superview

        while view != nil && !(view!.isMember(of: UITableView.self)) {
            view = view?.superview
        }

        return view as? UITableView
    }

}
#endif

//
//  UITableView+Deselect.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 31/07/2019.
//

#if os(iOS)
import UIKit

public extension UITableView {

    func deselectAllRows(animated: Bool) {
        if let indexPaths = self.indexPathsForSelectedRows {
            for indexPath in indexPaths {
                self.deselectRow(at: indexPath, animated: animated)
            }
        }
    }

}
#endif

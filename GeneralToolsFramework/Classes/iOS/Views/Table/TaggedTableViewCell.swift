//
//  TaggedTableViewCell.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 12/02/2019.
//

#if os(iOS)
import UIKit

open class TaggedTableViewCell: UITableViewCell {

    public var tagView: ZSTagView? {
        get {
            return self.accessoryView as? ZSTagView
        }
        set {
            self.accessoryView = newValue
        }
    }

}
#endif

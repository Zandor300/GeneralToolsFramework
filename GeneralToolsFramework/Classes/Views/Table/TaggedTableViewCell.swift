//
//  TaggedTableViewCell.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 12/02/2019.
//

import UIKit

public class TaggedTableViewCell: UITableViewCell {
    
    public var tagView: UITagView? {
        get {
            return self.accessoryView as? UITagView
        }
        set {
            self.accessoryView = newValue
        }
    }
    
}

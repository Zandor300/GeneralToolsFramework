//
//  UISwitchTableViewCell.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

import UIKit

class UISwitchTableViewCell: UITableViewCell {
    
    var callback: (Bool) -> () = { state in }
    
    let theSwitch = UISwitch()
    
    var switchTintColor: UIColor {
        get {
            return theSwitch.tintColor
        }
        set {
            theSwitch.tintColor = newValue
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupSwitch()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSwitch()
    }
    
    private func setupSwitch() {
        self.selectionStyle = .none
        self.accessoryView = theSwitch
        addSwitchTarget(target: self, action: #selector(self.executeCallback), for: .valueChanged)
    }
    
    public func setSwitchState(state: Bool, animated: Bool) {
        theSwitch.setOn(state, animated: animated)
    }
    
    public func addSwitchTarget(target: Any?, action: Selector, for event: UIControlEvents) {
        theSwitch.addTarget(target, action: action, for: event)
    }
    
    public func setStateChangedCallback(callback: @escaping (Bool) -> ()) {
        self.callback = callback
    }
    
    @objc func executeCallback() {
        callback(theSwitch.isOn)
    }
    
}

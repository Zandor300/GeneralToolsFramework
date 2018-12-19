//
//  Float+DutchString.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

import Foundation

extension Float {
    
    public var dutchStringValue: String {
        return String(self).replacingOccurrences(of: ".", with: ",")
    }
    
}

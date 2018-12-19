//
//  String+Contains.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

import Foundation

extension String {
    
    public func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    public func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
}

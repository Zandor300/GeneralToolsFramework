//
//  Upload.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/01/2019.
//

import Foundation

public enum UploadType: String {
    case PNG = "image/png"
    case JPG = "image/jpg"
}

public class Upload {

    let name: String
    let data: Data
    let type: UploadType

    public init(name: String, data: Data, type: UploadType) {
        self.name = name
        self.data = data
        self.type = type
    }

}

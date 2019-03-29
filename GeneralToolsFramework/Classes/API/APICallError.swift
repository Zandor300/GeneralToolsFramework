//
//  APICallError.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 29/01/2019.
//

import Foundation

public enum APICallError {
    case noInternet
    case serverUnavailable
    case receivedException
    case postContentInvalid
    case sessionExpired
    case loginExpired
    case invalidCredentials
    case accountInactive
    case unknown
}

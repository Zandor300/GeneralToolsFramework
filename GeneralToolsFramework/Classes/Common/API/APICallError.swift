//
//  APICallError.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 29/01/2019.
//

import Foundation

public enum APICallError {

    // Network related errors
    case noInternet
    case serverUnavailable
    case networkError
    case sslCertificateExpired
    case sslCertificateError
    case serverTimeout
    case roamingDisabled

    // API related errors
    case receivedException
    case invalidParameters
    case missingParameters
    case postContentInvalid
    case sessionExpired
    case loginExpired
    case invalidCredentials
    case accountInactive
    case emailInUse // Registration
    case passwordsNotMatching // Registration
    case unexpectedResponse
    case unknown

}

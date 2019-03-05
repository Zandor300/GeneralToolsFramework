//
//  BuildConfig.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 28/12/2018.
//

import Foundation

public enum AppConfiguration {
    case debug
    case testFlight
    case appStore
}

public struct BuildConfig {

    // This is private because the use of 'appConfiguration' is preferred.
    private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"

    // This can be used to add debug statements.
    public static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    public static var appConfiguration: AppConfiguration {
        if isDebug {
            return .debug
        } else if isTestFlight {
            return .testFlight
        } else {
            return .appStore
        }
    }

}

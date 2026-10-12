//
//  NetworkActivityHandler.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 10/12/2018.
//

#if os(iOS)
import UIKit

public class NetworkActivityHandler {

    static var count: Int = 0

    public static func pushNetworkActivity() {
        count += 1
        updateActivityIndicator()
    }

    public static func popNetworkActivity() {
        count -= 1
        updateActivityIndicator()
    }

    /// The network activity indicator of the status bar has been removed in iOS 13, so only the count is validated.
    /// `UIApplication.shared` isn't used, so the framework can be used in app extensions.
    private static func updateActivityIndicator() {
        if count < 0 {
            assertionFailure("Count is below 0. You used one too many popNetworkActivity()")
        }
    }

}
#endif

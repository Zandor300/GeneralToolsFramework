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

    /// `UIApplication.shared` is unavailable in app extensions, so it's looked up at runtime instead.
    /// Returns `nil` when running in an app extension, since there is no shared application there.
    private static var sharedApplication: UIApplication? {
        guard Bundle.main.bundleURL.pathExtension != "appex" else { return nil }
        return UIApplication.perform(NSSelectorFromString("sharedApplication"))?.takeUnretainedValue() as? UIApplication
    }

    private static func updateActivityIndicator() {
        #if !targetEnvironment(macCatalyst)
        DispatchQueue.main.async {
            if count > 0 {
                sharedApplication?.isNetworkActivityIndicatorVisible = true
            } else {
                sharedApplication?.isNetworkActivityIndicatorVisible = false
                if count < 0 {
                    assertionFailure("Count is below 0. You used one too many popNetworkActivity()")
                }
            }
        }
        #endif
    }

}
#endif

//
//  NetworkActivityHandler.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 10/12/2018.
//

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

    private static func updateActivityIndicator() {
        DispatchQueue.main.async {
            if count > 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if count < 0 {
                    assertionFailure("Count is below 0. You used one too many popNetworkActivity()")
                }
            }
        }
    }

}

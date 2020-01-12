//
//  UIViewController+Top.swift
//  Connectivity
//
//  Created by Zandor Smith on 12/01/2020.
//

import UIKit

extension UIViewController {

    /// Returns the top most presented UIViewController from the current UIViewController. If no viewcontrollers were presented from the current one, the current will be returned.
    public func topPresentedViewController() -> UIViewController {
        var topViewController = self
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }

}

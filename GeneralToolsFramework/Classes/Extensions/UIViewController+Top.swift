//
//  UIViewController+Top.swift
//  Connectivity
//
//  Created by Zandor Smith on 12/01/2020.
//

import UIKit

extension UIViewController {

    func topPresentedViewController() -> UIViewController {
        var topViewController = self
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }

}

//
//  UIViewController+Dismiss.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 12/02/2019.
//

#if os(iOS) || os(tvOS)
import UIKit

extension UIViewController {

    /// Dismiss all presented view controllers that were presented from this one and childs from this until the current one is shown. onCompletion is called when done.
    public func dismissViewControllers(animated: Bool, onCompletion: (() -> Void)?) {
        guard let viewController = self.presentingViewController else {
            if let handler = onCompletion {
                handler()
            }
            return
        }

        while viewController.presentingViewController != nil {
            viewController.dismiss(animated: animated) {
                if viewController.presentingViewController == nil {
                    if let handler = onCompletion {
                        handler()
                    }
                }
            }
        }
    }

    /// Dismiss all presented view controllers that were presented from this one and childs from this until the current one is shown. onCompletion is called when done.
    @available(iOS 13.0, *)
    public func dismissViewControllers(animated: Bool) async {
        return await withCheckedContinuation { continuation in
            self.dismissViewControllers(animated: animated) {
                continuation.resume()
            }
        }
    }

}
#endif

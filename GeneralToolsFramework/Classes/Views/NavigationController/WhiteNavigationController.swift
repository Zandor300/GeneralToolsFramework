//
//  WhiteNavigationController.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 13/02/2019.
//

import UIKit

open class WhiteNavigationController: UINavigationController {

    public var barBlur: WhiteNavigationBarBlur?

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        self.barBlur = WhiteNavigationBarBlur(effect: UIBlurEffect(style: .light))

        self.navigationBar.isTranslucent = true
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.addSubview(self.barBlur!)

        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.barBlur?.layoutSubviews()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @objc func deviceOrientationDidChange(_ notification: Notification) {
        self.barBlur?.layoutSubviews()
    }

}

public class WhiteNavigationBarBlur: UIVisualEffectView {

    let whiteView = UIView()

    var centerLabelSuperview: UIView?

    var navigationBar: UINavigationBar? {
        return self.superview as? UINavigationBar
    }

    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.contentView.addSubview(whiteView)
        self.whiteView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
    }

    override public func layoutSubviews() {
        if let navigationBar = self.navigationBar {
            let statusBarHeight = UIApplication.shared.statusBarFrame.size.height

            if self.centerLabelSuperview == nil {
                for subview in navigationBar.subviews {
                    for subsubview in subview.subviews {
                        if subsubview.isMember(of: UILabel.self) {
                            let subviewName = String(describing: subview.self)
                            if !subviewName.contains(find: "Large") {
                                self.centerLabelSuperview = subsubview.superview
                            }
                        }
                    }
                }
            }

            if let bounds = self.centerLabelSuperview?.bounds {
                self.frame = bounds.insetBy(dx: 0, dy: -(statusBarHeight)).offsetBy(dx: 0, dy: -(statusBarHeight))
            } else {
                self.frame = navigationBar.bounds.insetBy(dx: 0, dy: -(statusBarHeight)).offsetBy(dx: 0, dy: -(statusBarHeight))
            }

            self.whiteView.frame = self.contentView.bounds

            navigationBar.sendSubviewToBack(self)
        }
    }

}

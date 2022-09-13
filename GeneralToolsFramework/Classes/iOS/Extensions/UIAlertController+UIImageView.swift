//
//  UIAlertController+UIImageView.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 12/02/2019.
//

#if os(iOS)
import UIKit

extension UIAlertController {

    public func addImageView(withImage image: UIImage) -> UIImageView {
        return self.addImageView(withImage: image, size: 125)
    }

    public func addImageView(withImage image: UIImage, size: CGFloat) -> UIImageView {
        let imageView: UIImageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)

        imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: size))
        imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: size))
        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 10.0))
        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        return imageView
    }

}
#endif

//
//  ZSTagView.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 12/02/2019.
//

#if os(iOS) || os(tvOS)
import UIKit

public class ZSTagView: UIView {

    var label: UILabel

    public var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
            updateSize()
        }
    }

    public var textColor: UIColor! {
        get {
            return label.textColor
        }
        set {
            label.textColor = newValue
        }
    }

    public var allowClearBackgroundColor: Bool = false

    public override var backgroundColor: UIColor? {
        set {
            if !allowClearBackgroundColor && newValue == .clear {
                return
            }
            super.backgroundColor = newValue
        }
        get {
            return super.backgroundColor
        }
    }

    public init() {
        // Create label
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 24))
        label.text = "Label"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1

        super.init(frame: CGRect(x: 0, y: 0, width: 70, height: 24))

        self.backgroundColor = .black
        self.addSubview(label)

        self.updateSize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateSize() {
        label.sizeToFit()

        let labelBounds = label.bounds
        self.bounds = CGRect(x: 0, y: 0, width: labelBounds.width + 12, height: labelBounds.height + 6)
        label.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)

        self.layer.cornerRadius = self.bounds.height / 2
    }

}
#endif

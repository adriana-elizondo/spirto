//
//  UIExtensions.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/24.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    convenience init(nibName: String? = nil) {
        guard nibName != nil else {
            self.init(nibName: String(describing: type(of: self)), bundle: nil)
            return
        }
        self.init(nibName: nibName, bundle: nil)
    }
}
extension UIView {
    func scaleUpDown() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { (_) in
            self.transform = .identity
        }
    }
}
extension UIColor {
    static func spirtoColor() -> UIColor {
        return UIColor(displayP3Red: 131/255.0, green: 35/255.0, blue: 57/255.0, alpha: 1.0)
    }
}
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        image = templateImage
        tintColor = color
    }
}
extension UIButton {
    func disableMe() {
        isEnabled = false
        setTitleColor(UIColor.gray.withAlphaComponent(0.5), for: .normal)
    }
    func enableMe(with tintColor: UIColor? = UIColor.spirtoColor()) {
        isEnabled = true
        setTitleColor(tintColor, for: .normal)
    }
}

//
//  UIViewControllerExtensions.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/30.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    convenience init(name: String?) {
        guard name != nil else {
            self.init(nibName: String(describing: type(of: self)), bundle: nil)
            return
        }

        self.init(nibName: name, bundle: nil)
    }
}

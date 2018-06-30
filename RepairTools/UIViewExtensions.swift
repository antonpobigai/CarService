//
//  UIViewExtensions.swift
//  RepairTools
//
//  Created by admin on 20.06.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func dropMyShadow(color: UIColor, radius: CGFloat, offSet: CGSize) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}

//
//  Helper.swift
//  RepairTools
//
//  Created by admin on 19.06.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import  UIKit

class Helper {
    static func makeButtonRounded(button: UIButton, byRadius: CGFloat) {
        button.layer.cornerRadius = byRadius
        button.layer.borderWidth = 0
    }
    static func makeButtonCircular(button: UIButton) {
        button.layer.cornerRadius = button.bounds.width / 2
        button.layer.borderWidth = 0
    }
}

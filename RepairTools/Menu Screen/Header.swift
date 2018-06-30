//
//  Header.swift
//  RepairTools
//
//  Created by admin on 23.06.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit

class Header: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UIButton!
    @IBOutlet weak var emailLabel: UIButton!
    @IBOutlet weak var addressLabel: UIButton!
    @IBOutlet weak var reviewsLabel: UIButton!
    @IBOutlet weak var timeStack: UIStackView!
    /*
     ICON COLORS:
     MAIL = RGB(37, 67, 105)
     PHONE = RGB(53, 148, 68)
     MAP = RGB(165, 12, 50)
     */
    @IBAction func callUsPressed(_ sender: UIButton) {
        if let url = URL(string: "tel://\(sender.titleLabel!.text!)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBAction func sendEmailPressed(_ sender: UIButton) {
        
    }
    @IBAction func showMapPressed(_ sender: UIButton) {
        
    }
    @IBAction func reviewsPressed(_ sender: UIButton) {
        
    }
}

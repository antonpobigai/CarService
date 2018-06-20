//
//  ViewController.swift
//  RepairTools
//
//  Created by admin on 08.06.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var menuItems = [
        "Selector 1", "Selector 2", "Selector 3",
        "Selector 4", "Selector 5", "Selector 6",
        "Selector 7", "Selector 8", "Selector 9"
    ]
    
    @IBOutlet weak var collectionMenuView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionMenuView.delegate = self
//        collectionMenuView.dataSource = self
        Helper.makeButtonCircular(button: callButton)
        Helper.makeButtonCircular(button: emailButton)
        Helper.makeButtonRounded(button: reviewButton, byRadius: 5)
        LoadTables.getBrandsList(fromFile: "brands.csv")
//ланос
    }
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
}

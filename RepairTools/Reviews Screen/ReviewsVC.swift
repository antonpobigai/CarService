//
//  ReviewsVC.swift
//  RepairTools
//
//  Created by admin on 24.06.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReviewsVC: UIViewController {
    
    var reviews = [Review]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        request(Server.globalName+Server.reviews+Server.client, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (_,subJson):(String,JSON) in json {
                    let name = subJson["name"].stringValue
                    let text = subJson["text"].stringValue
                    let mark = subJson["mark"].intValue
                    self.reviews.append((Review(title: name, text: text, mark: mark)))
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.25
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        cell.title.text = reviews[indexPath.row].title + "asdcwefverknfjbsvjhdsbjhcvbsdhvcshdvcsdcv sdvcshdgcvhsdvcnsbxvbnzxvcshdvhsd"
        cell.backgroundColor = Helper.selectColor(color: (247, 247, 247, 1))
        for mark in 0..<reviews[indexPath.row].mark {
            let img = cell.ratingStackView.subviews[mark] as! UIImageView
            img.image = #imageLiteral(resourceName: "icons8-звезда-filled-50").withRenderingMode(.alwaysTemplate)
            img.tintColor = Helper.selectColor(color: (255, 239, 0, 0.9))
        }
        return cell
    }
}

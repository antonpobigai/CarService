//
//  NewsVC.swift
//  RepairTools
//
//  Created by admin on 21.06.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsVC: UIViewController {
    var news = [New]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        request(Server.globalName+Server.news+Server.client, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (_,subJson):(String,JSON) in json {
                    let id = subJson["id"].intValue
                    let name = subJson["name"].stringValue
                    let text = subJson["text"].stringValue
                    let pictureURL = subJson["pictureURL"].stringValue
                    self.news.append(New(id: id, title: name, text: text, pictureURL: URL(string: pictureURL)))
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as! NewsCell
        cell.titleLabel.text = news[indexPath.row].title
        if let pic = news[indexPath.row].pictureURL {
            DispatchQueue.global(qos: .userInitiated).async {
                let data = try! Data(contentsOf: pic)
                DispatchQueue.main.async {
                    cell.newImage.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
}

//
//  MenuVC.swift
//  RepairTools
//
//  Created by admin on 23.06.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MenuVC: UIViewController {
    var list = [String]()
    var info: AboutUsInfo!
    var loadData = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        list.append("Selector1")
        list.append("Selector2")
        list.append("Selector3")
        list.append("Selector4")
        list.append("Selector5")
        list.append("Selector6")
        list.append("Selector7")
    }
//    func selectColor(color:(r:Int, g:Int, b:Int, a:Double)) -> UIColor {
//        return UIColor(red: CGFloat(color.r)/255.0, green: CGFloat(color.g)/255.0, blue: CGFloat(color.b)/255.0, alpha: CGFloat(color.a))
//    }
}
extension MenuVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! MenuCell
        let colorType = indexPath.row % 6
        var rgba:(Int, Int, Int, Double)!
        switch colorType {
        case 0:
            rgba = (70, 130, 180, 0.7)
            cell.title.text = "Category 1"
            cell.backgroundColor = Helper.selectColor(color: rgba)
            rgba.3 = 1
            cell.title.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageArrow.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageBackView.image = #imageLiteral(resourceName: "icons8-реактивный-двигатель-filled-100")
        case 1:
            rgba = (205, 92, 92,0.7)
            cell.title.text = "Category 2"
            cell.backgroundColor = Helper.selectColor(color: rgba)
            rgba.3 = 1
            cell.title.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageArrow.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageBackView.image = #imageLiteral(resourceName: "icons8-настройки-3-500.png")
        case 2:
            cell.title.text = "Category 3"
            rgba = (108, 8, 1, 0.7)
            cell.backgroundColor = Helper.selectColor(color: rgba)
            rgba.3 = 1
            cell.title.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageArrow.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageBackView.image = #imageLiteral(resourceName: "icons8-настройки-500.png")
        case 3:
            rgba = (0, 0, 205, 0.7)
            cell.title.text = "Category 4"
            cell.backgroundColor = Helper.selectColor(color: rgba)
            rgba.3 = 1
            cell.title.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageArrow.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageBackView.image = #imageLiteral(resourceName: "icons8-бензоколонка-filled-100")
        case 4:
            rgba = (25, 25, 112, 0.7)
            cell.title.text = "Category 5"
            cell.backgroundColor = Helper.selectColor(color: rgba)
            rgba.3 = 1
            cell.title.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageArrow.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageBackView.image = #imageLiteral(resourceName: "icons8-обслуживание-100")
        case 5:
            cell.title.text = "Category 6"
            rgba = (53, 4, 25, 0.7)
            cell.backgroundColor = Helper.selectColor(color: rgba)
            rgba.3 = 1
            cell.title.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageArrow.backgroundColor = Helper.selectColor(color: rgba)
            cell.imageBackView.image = #imageLiteral(resourceName: "icons8-настройки-500.png")
        default:
            break
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.width/2 - 2
        return CGSize(width: w, height: w)
    }
    func installFontScale(btn: UIButton) {
        btn.titleLabel?.minimumScaleFactor = 0.5
        btn.titleLabel?.numberOfLines = 1
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.baselineAdjustment = UIBaselineAdjustment.alignCenters
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! Header
            Helper.makeButtonsRounded(buttons: [head.reviewsLabel], byRadius: 15)
            if !loadData {
                request(Server.globalName+Server.aboutUs+"/sto", method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let name = json["name"].stringValue
                        let phone = json["phone"].intValue
                        let email = json["email"].stringValue
                        let address = json["address"].stringValue
                        
                        var times = [AboutUsInfo.WorkTime]()
                        for (_,subJson):(String,JSON) in json["workDays"] {
                            let fromDay = subJson["from"]["day"].stringValue
                            let fromHour = subJson["from"]["hour"].stringValue
                            let fromMinute = subJson["from"]["minute"].stringValue
                            
                            let toDay = subJson["to"]["day"].stringValue
                            let toHour = subJson["to"]["hour"].stringValue
                            let toMinute = subJson["to"]["minute"].stringValue
                            
                            times.append(AboutUsInfo.WorkTime(
                                from: AboutUsInfo.Time(day: fromDay, h: fromHour, m: fromMinute),
                                to: AboutUsInfo.Time(day: toDay, h: toHour, m: toMinute)))
                            
                            let lbl :UILabel = {
                                let lbl = UILabel()
                                lbl.text = "\(fromDay) - \(fromHour) \(fromMinute):\(toDay) - \(toHour):\(toMinute)"
                                lbl.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
                                lbl.textColor = UIColor.white
                                lbl.textAlignment = .center
                                return lbl
                            }()
                            head.timeStack.addArrangedSubview(lbl)
                        }
                        self.info = AboutUsInfo(name: name, phone: phone, email: email, address: address, workTimes: times)
                        
                        head.titleLabel.text = self.info.name
                        
                        head.addressLabel.setImage(head.addressLabel.currentImage?.withRenderingMode(.alwaysTemplate), for: .normal)
                        head.addressLabel.setTitle(self.info.address, for: .normal)
                        self.installFontScale(btn: head.addressLabel)
                        
                        head.phoneLabel.setImage(head.phoneLabel.currentImage?.withRenderingMode(.alwaysTemplate), for: .normal)
                        head.phoneLabel.setAttributedTitle(NSAttributedString(string: "\(self.info.phone)", attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]), for: .normal)
                        self.installFontScale(btn: head.phoneLabel)
                        
                        head.emailLabel.setImage(head.emailLabel.currentImage?.withRenderingMode(.alwaysTemplate), for: .normal)
                        head.emailLabel.setTitle(self.info.email, for: .normal)
                        self.installFontScale(btn: head.emailLabel)
                        
                        self.loadData = true
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            return head
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

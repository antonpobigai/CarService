//
//  AboutUsInfo.swift
//  RepairTools
//
//  Created by admin on 24.06.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

struct AboutUsInfo {
    let name: String
    let phone: Int
    let email: String?
    let address: String
    let workTimes: [WorkTime]
    
    struct WorkTime {
        let from: Time
        let to: Time
    }
    struct Time {
        let day: String
        let h: String
        let m: String
    }
}

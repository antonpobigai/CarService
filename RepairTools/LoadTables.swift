//
//  LoadTables.swift
//  RepairTools
//
//  Created by admin on 08.06.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
struct LoadTables {
    private init() {}
    
    static func getBrandsList(fromFile path: String) {
        let components = path.components(separatedBy: ".")
        if let name = components.first,
            let expresion = components.last,
            let filepath = Bundle.main.path(forResource: name, ofType: expresion) {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let lines = contents.components(separatedBy: "\n")
                
                for line in lines {
                    print(line)
                }
            }
            catch {
                print("Coun't load contents from file.")
                return
            }
        }
    }
    
    static func getModelList(byBrand name: String) {
        let tName = String(name.map {
            $0 == " " ? "_" : $0
        })
        if let filepath = Bundle.main.path(forResource: tName, ofType: ".csv") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let lines = contents.components(separatedBy: "\n")
                
                for line in lines {
                    print(line)
                }
            }
            catch {
                print("Coun't load contents from file.")
                return
            }
        }
    }
}

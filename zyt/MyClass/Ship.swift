//
//  Ship.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/11/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation

class Ship: NSObject {
    
    var name: String!
    var number: String!
    var coor: CLLocationCoordinate2D!
    var deviceInstall: Bool!
    
    override init() {
        name = "name"
        number = "number"
        coor = CLLocationCoordinate2DMake(30, 122)
        deviceInstall = false
    }
    
}

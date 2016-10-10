//
//  MyAnnotation.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/11/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation

enum MyAnnotationType {
    case start
    case end
    case point
}

class MyAnnotation: BMKPointAnnotation {
    
    var type: MyAnnotationType = .point
    var index: Int?
    
}

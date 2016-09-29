//
//  TabBarController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/11/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit
//import Alamofire
//import SwiftyJSON
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


func updateTodoNumber(number: String, item: UITabBarItem) {
    item.badgeValue = number
}

class TabBarController: UITabBarController {
    
    var ships = [Ship]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor.tabBarColor()

        NotificationCenter.default.addObserver(self, selector: #selector(TabBarController.didReceiveShipsData(_:)), name: NSNotification.Name(rawValue: "didReceiveShipsData"), object: nil)

        checkUpdate()
        
        updateTodoNumber(number: "2", item: self.tabBar.items![2])
        
        checkPhone()
    }
    
    func checkPhone() {
        if iPhone4() {
            print("check phone: iPhone4\n")
        }
        
        if iPhone5() {
            print("check phone: iPhone5\n")
        }
        
        if iPhone6() {
            print("check phone: iPhone6\n")
        }
        
        if iPhone6P() {
            print("check phone: iPhone6P\n")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("****appeear")
    }
    
    func didReceiveShipsData(_ notification: Notification) {
        self.ships = (notification.object as? [Ship])!
    }
    
    func checkUpdate() {
        
        let okHandler = { (action: UIAlertAction!) -> Void in
            let url = URL(string: appViewUrl)
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.openURL(url!)
            } else {
                print("cannot open app store ")
            }
        }
        
//        Alamofire.request(.POST, checkUpdateUrl, parameters: ["id": 1071530431]).responseJSON { response in
//            switch response.result {
//            case .Success(let value):
//                let results = JSON(value)["results"].arrayValue
//                let version = results[0]["version"].stringValue
//                let description = results[0]["description"].stringValue
//                if self.compareVersionsFromAppStore(version) {
//                    alertView("\(version)版本已发布", message: "更新内容:\n\(description)", okActionTitle: "升级", cancleActionTitle: "取消", okHandler: okHandler, viewController: self)
//                    let showUpdateTime = NSDate().timeIntervalSince1970
//                    NSUserDefaults.standardUserDefaults().setDouble(showUpdateTime, forKey: "showUpdateTime")
//                    print("need update: serverVersion: \(version)")
//                } else{
//                    print("no update: serverVersion: \(version)")
//                }
//            case .Failure(let error):
//                print("check update error: \n\(error)")
//            }
//        }
        
    }
    
    func compareVersionsFromAppStore(_ AppStoreVersion: String) -> Bool {
        
        let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
        if AppVersion == nil {
            return false
        }
        
        var aArray = AppStoreVersion.components(separatedBy: ".")
        var bArray = (AppVersion! as AnyObject).components(separatedBy: ".")
        
        while aArray.count < bArray.count { aArray.append("0") }
        while aArray.count > bArray.count { bArray.append("0") }
        
        for i in 0 ... aArray.count - 1 {
            if Int(aArray[i]) > Int(bArray[i]) {
                return true
            }
        }
        
        return false
        
    }
    
}

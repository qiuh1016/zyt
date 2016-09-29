//
//  ViewController.swift
//  zyt
//
//  Created by qiuhong on 9/17/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkUpdate()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let appViewUrl = "itms-apps://itunes.apple.com/us/app/ren-chuan-lian-dong/id1071530431?mt=8&uo=4"
    let checkUpdateUrl = "http://itunes.apple.com/lookup"
    

    func checkUpdate() {
        
        let okHandler = { (action: UIAlertAction!) -> Void in
            let url = URL(string: self.appViewUrl)
            if UIApplication.shared.canOpenURL(url!) {
//                UIApplication.shared.openURL(url!)
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            } else {
                print("cannot open app store ")
            }
        }
        
        Alamofire.request(checkUpdateUrl, method: .post, parameters: ["id": 1071530431], encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
            switch response.result {
            case .success(let value):
                print(JSON(value))
                
            case .failure(let e):
                print(e)
            }
        }
//        Alamofire.request(checkUpdateUrl, .POST, parameters: ["id": 1071530431]).responseJSON { response in
//            switch response.result {
//            case .Success(let value):
//                print(value)
////                let results = JSON(value)["results"].arrayValue
////                let version = results[0]["version"].stringValue
////                let description = results[0]["description"].stringValue
////                if self.compareVersionsFromAppStore(version) {
////                    alertView("\(version)版本已发布", message: "更新内容:\n\(description)", okActionTitle: "升级", cancleActionTitle: "取消", okHandler: okHandler, viewController: self)
////                    let showUpdateTime = NSDate().timeIntervalSince1970
////                    NSUserDefaults.standardUserDefaults().setDouble(showUpdateTime, forKey: "showUpdateTime")
////                    print("need update: serverVersion: \(version)")
////                } else{
////                    print("no update: serverVersion: \(version)")
////                }
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
            if Int(aArray[i])! > Int(bArray[i])! {
                return true
            }
        }
        
        return false
        
    }


}


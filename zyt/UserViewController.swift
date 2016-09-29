//
//  UserViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

class UserViewController: UIViewController {
    
    var lineTexts = ["修改密码", "我的待办", "版本信息"]
    
    var taps = [UITapGestureRecognizer]()
    var selectors = [Selector]()
    
    var loginButton: UIButton!
    var hasLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initNavigationBar()
        initTap()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        
        hasLogin = defaults.bool(forKey: "hasLogin")
        loginButton.setTitle(hasLogin ? "退出" : "登陆", for: UIControlState())
        loginButton.backgroundColor = hasLogin ? UIColor.logoutTextColor() : UIColor.mainColor()
    }
    
    func initTap() {
        selectors.append(#selector(ServiceViewController.tapped1(_:)))
        selectors.append(#selector(ServiceViewController.tapped2(_:)))
        selectors.append(#selector(ServiceViewController.tapped3(_:)))
        
        for selector in selectors {
            let tap = UITapGestureRecognizer(target: self, action: selector)
            taps.append(tap)
        }
        
    }
    
    func initNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
        self.navigationController?.navigationBar.titleTextAttributes =  [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func initView() {
        
        let lineNumber = lineTexts.count
        var lineHeight = 55
        let imageWidth = 21
        let space = 15
        var textSize: CGFloat = 15
        
        if self.view.frame.height == 480 || self.view.frame.height == 568 {
            lineHeight = 44
            textSize = 14
        }
        
        view.backgroundColor = UIColor.colorFromRGB(rgbValue: 0xEEEEEE, alpha: 1)
        
        //contentView
        let viewWidth = self.view.bounds.width - 20
        let contentView = UIView(frame: CGRect(x: 10, y: 20, width: viewWidth, height: CGFloat(lineHeight * lineNumber + lineNumber + 1)))
        contentView.backgroundColor = UIColor.spaceLineColor()
        makeRoundedCorner(view: contentView, corners: [UIRectCorner.allCorners], cornerRadii: kOuterCornerRadii)
        view.addSubview(contentView)
        
        //lineView
        for i in 0 ... lineNumber - 1{
            let lineView = UIView(frame: CGRect(x: 1, y: CGFloat(lineHeight * i + i + 1), width: viewWidth - 2, height: CGFloat(lineHeight)))
            lineView.backgroundColor = (i % 2 == 0) ? UIColor.mainLightColor() : UIColor.white
            lineView.isUserInteractionEnabled = true
            lineView.addGestureRecognizer(taps[i])
            
            if lineNumber == 1 {
                makeRoundedCorner(view: lineView, corners: [UIRectCorner.allCorners], cornerRadii: kInnerCornerRadii)
            } else {
                if i == lineNumber - 1 {
                    makeRoundedCorner(view: lineView, corners: [UIRectCorner.bottomLeft, .bottomRight], cornerRadii: kInnerCornerRadii)
                } else if i == 0 {
                    makeRoundedCorner(view: lineView, corners: [UIRectCorner.topLeft, .topRight], cornerRadii: kInnerCornerRadii)
                }
            }
            
            //text
            let label = UILabel(frame: CGRect(x: CGFloat(space), y: 0, width: lineView.bounds.width - CGFloat(3 * space) - CGFloat(imageWidth), height: CGFloat(lineHeight)))
            label.text = lineTexts[i]
            label.textColor = UIColor.textColor()
            label.font = UIFont(name: textFontName, size: textSize)
            label.backgroundColor = UIColor.clear
            
            //imageView
            let arrawImageView = UIImageView(image: UIImage(named: "setting_arrow_big"))
            arrawImageView.frame = CGRect(x: lineView.bounds.width - CGFloat(space) - CGFloat(imageWidth), y: CGFloat((lineHeight - imageWidth) / 2), width: CGFloat(imageWidth), height: CGFloat(imageWidth))
            arrawImageView.contentMode = .scaleAspectFit
            
            lineView.addSubview(label)
            lineView.addSubview(arrawImageView)
            contentView.addSubview(lineView)
        }
        
        
        //login Button
        loginButton = UIButton(type: .system)
        loginButton.frame = CGRect(x: 10, y: contentView.frame.maxY + 20, width: viewWidth, height: CGFloat(lineHeight + 2))
        loginButton.setTitle("登陆", for: UIControlState())
        loginButton.layer.cornerRadius = kCornerRadii
        loginButton.layer.masksToBounds = true
        loginButton.backgroundColor = UIColor.mainColor()
        loginButton.setTitleColor(UIColor.white, for: UIControlState())
        loginButton.addTarget(self, action: #selector(UserViewController.loginButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    func tapped1(_ sender: UITapGestureRecognizer) {
        print("\(lineTexts[0])")
    }
    
    func tapped2(_ sender: UITapGestureRecognizer) {
        print("\(lineTexts[1])")
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "ServiceViewController") as! ServiceViewController
        vc.index = 5
        self.navigationController?.show(vc, sender: nil)
        
    
    }
    
    func tapped3(_ sender: UITapGestureRecognizer) {
        print("\(lineTexts[2])")
        performSegue(withIdentifier: "versionSegue", sender: nil)
    }
    
    func loginButtonTapped(_ sender: UIButton) {
    
        if hasLogin {
            let hudView = HudView.hudInView(view: self.view, animated: true)
            hudView.text = "退出中"
            afterDelay(1.0) {
                hudView.hideAnimated(view: self.view, animated: false)
                let okView = OKView.hudInView(view: self.view, animated: false)
                okView.text = "退出成功"
                afterDelay(0.5) {
                    okView.hideAnimated(view: self.view, animated: true)
                    Foundation.UserDefaults.standard.set(false, forKey: "hasLogin")
                    self.loginButton.setTitle("登陆", for: UIControlState())
                    self.loginButton.backgroundColor = UIColor.mainColor()
                }
            }
        } else {
            let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(withIdentifier: "LoginNavigationViewController")
            present(vc, animated: true, completion: nil)
        }
        
        hasLogin = !hasLogin
        
    }
    
}

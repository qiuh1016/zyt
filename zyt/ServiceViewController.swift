//
//  ServerViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController {
    
    
    var index : Int!
    var lineNumbers = [3, 5, 4, 1, 3, 4]
    var titles = ["业务办理", "记录查询", "电子签证", "法律法规", "业务流程", "待办任务"]
    var lineTexts = [
        ["渔船检验申报", "图纸审查申报", "图纸审查申报"],
        ["投保记录查询", "投保记录查询", "交易记录查询", "检验记录查询", "审图记录查询"],
        ["出港确认", "进港确认", "打卡记录", "出海记录"],
        ["法律法规"],
        ["渔船检验业务流程", "渔船登记业务流程", "捕捞许可业务流程"],
        ["审图意见书", "报检单", "整改意见书", "检验记录"]
    ]
    
    var taps = [UITapGestureRecognizer]()
    var selectors = [Selector]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titles[index]
        initTap()
        initView()
    }

    func initTap() {
        selectors.append(#selector(ServiceViewController.tapped1(_:)))
        selectors.append(#selector(ServiceViewController.tapped2(_:)))
        selectors.append(#selector(ServiceViewController.tapped3(_:)))
        selectors.append(#selector(ServiceViewController.tapped4(_:)))
        selectors.append(#selector(ServiceViewController.tapped5(_:)))
        
        for selector in selectors {
            let tap = UITapGestureRecognizer(target: self, action: selector)
            taps.append(tap)
        }

    }
    
    func initView() {
        
        let lineNumber = lineTexts[index].count
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
        
        if lineNumber == 0 {
            return
        }
        
        
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
            label.text = lineTexts[index][i]
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
        
        
        
    }

    
    func tapped1(_ sender: UITapGestureRecognizer) {
        print("\(lineTexts[index][0])")
        
    }
    
    func tapped2(_ sender: UITapGestureRecognizer) {
        print("\(lineTexts[index][1])")
        
    }
    
    func tapped3(_ sender: UITapGestureRecognizer) {
        print("\(lineTexts[index][2])")
        
    }
    
    func tapped4(_ sender: UITapGestureRecognizer) {
        print("\(lineTexts[index][3])")
        
    }
    
    func tapped5(_ sender: UITapGestureRecognizer) {
        print("\(lineTexts[index][4])")
        
    }
    
    
    

    
}

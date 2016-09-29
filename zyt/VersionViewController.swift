//
//  VersionViewController.swift
//  zyt
//
//  Created by qiuhong on 29/09/2016.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class VersionViewController: UIViewController {
    
    let lineTexts = ["版本更新", "版本信息"]
    var versionLabelMaxY: CGFloat = 0.0
    var taps = [UITapGestureRecognizer]()
    var selectors = [Selector]()
    
//    var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTap()
        initView()
    }
    
    func initView() {
        let imageWidth = screenW * 1 / 3
        let imageX = (screenW - imageWidth) / 2
        let imageY = imageWidth / 2
        
        let imageView = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageWidth, height: imageWidth))
        imageView.image = UIImage(named: "appicon")
        makeRoundedCorner(view: imageView, corners: .allCorners, cornerRadii: CGSize(width: 20, height: 20))
        self.view.addSubview(imageView)
        
        let versionLabel = UILabel(frame: CGRect(x: imageX, y: imageY + imageWidth + 10, width: imageWidth, height: 30))
        versionLabel.text = "版本: 2.0.0"
        versionLabel.font = UIFont.systemFont(ofSize: 12)
        versionLabel.textColor = UIColor.darkGray
        versionLabel.textAlignment = .center
        self.view.addSubview(versionLabel)
        
        versionLabelMaxY = versionLabel.frame.maxY
        
        initLineView()
    }
    
    func initLineView() {
        
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
        let contentView = UIView(frame: CGRect(x: 10, y: versionLabelMaxY + 10 , width: viewWidth, height: CGFloat(lineHeight * lineNumber + lineNumber + 1)))
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
    }
    
    func initTap() {
        selectors.append(#selector(VersionViewController.tapped1(_:)))
        selectors.append(#selector(VersionViewController.tapped2(_:)))
        
        for selector in selectors {
            let tap = UITapGestureRecognizer(target: self, action: selector)
            taps.append(tap)
        }
    }
    
    func tapped1(_ sender: UITapGestureRecognizer) {
        print("\(lineTexts[0])")
        alertView(title: "提示", message: "已是最新版本,无需更新!", okActionTitle: "好的", okHandler: nil, viewController: self)
    }
    
    func tapped2(_ sender: UITapGestureRecognizer) {
        print("\(lineTexts[1])")
        alertView(title: "更新", message: "更新内容:", okActionTitle: "好的", okHandler: nil, viewController: self)
        
    }
}

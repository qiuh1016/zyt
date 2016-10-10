//
//  SMSCodeNumberView.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/12/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

class SMSCodeView: UIView {
    
    var label : UILabel!
    
    var text = "" {
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: rect.width, height: 30))
        label.text = text
        label.font = UIFont(name: smsCodeFontName, size: 32)
        label.textColor = UIColor.mainColor() // UIColor.colorFromRGB(0x666666, alpha: 1)
        label.textAlignment = .center
        self.addSubview(label)
        
        
        let lineView = UIView(frame: CGRect(x: 5, y: 42, width: rect.width - 10, height: 1))
        lineView.backgroundColor = UIColor.colorFromRGB(rgbValue: 0x999999, alpha: 1)
        self.addSubview(lineView)
        
    }
    
}

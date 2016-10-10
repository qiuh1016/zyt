//
//  GridView.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/10/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

private let margin: CGFloat = 8
private let labelHeight: CGFloat = 16

class GridView: UIView {
    
    var text: String!
    var image: UIImage!
    var clickCallBack: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        let tap = UITapGestureRecognizer(target: self, action: #selector(GridView.click(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let imageView = UIImageView(frame: CGRect(x: margin, y: margin, width: rect.width - 2 * margin, height: rect.height - 3 * margin - 16 ))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.white
        self.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x: margin, y: imageView.frame.maxY + margin, width: rect.width - 2 * margin, height: labelHeight))
        label.text = text
        label.font = UIFont(name: textFontName, size: 13.0)
        label.textColor = UIColor.textColor()
        label.textAlignment = .center
        self.addSubview(label)
        
    }
    
    func click(sender: UITapGestureRecognizer) {
        if clickCallBack != nil {
            clickCallBack!()
        }
    }
}

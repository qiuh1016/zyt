//
//  SMSCodeViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/12/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class SMSCodeViewController: UIViewController {
    
    var headLabel = UILabel()
    var codeView1 = SMSCodeView()
    var codeView2 = SMSCodeView()
    var codeView3 = SMSCodeView()
    var codeView4 = SMSCodeView()
    var resendLabel = UILabel()
    @IBOutlet weak var textfield: UITextField!

    var keyboardHeight: CGFloat = 0
    var hasDraw = false
    
    var timer: Timer?
    
    let smsCode = "6767"
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        textfield.becomeFirstResponder()
        textfield.addTarget(self, action: #selector(SMSCodeViewController.editingChanged), for: .editingChanged)
        textfield.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillAppear(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    func initView() {
        hasDraw = true
        
        let screenW = self.view.bounds.width
        let screenH = self.view.bounds.height
        
        let codeViewW = (screenW * 2 / 3) / 4
        
        let space = (screenW - codeViewW * 4) / 13
        let margin: CGFloat = space * 5

        let codeViewY: CGFloat =  (screenH - keyboardHeight) / 2 + codeViewW / 2
        let headLabelY: CGFloat = codeViewY / 2
        
        var fontSize: CGFloat = 32
        if screenH == 480 || screenH == 568 {
            fontSize = 30
        }
        
        headLabel = UILabel(frame: CGRect(x: 0, y: headLabelY, width: screenW, height: 40))
        headLabel.text = "输入短信验证码"
        headLabel.font = UIFont(name: textFontName, size: fontSize)
        headLabel.textColor = UIColor.colorFromRGB(rgbValue: 0x999999, alpha: 1) //UIColor.mainColor()  // 
        headLabel.textAlignment = .center
        self.view.addSubview(headLabel)
        
        codeView1 = SMSCodeView(frame: CGRect(x: margin                            , y: codeViewY , width: codeViewW, height: codeViewW))
        codeView2 = SMSCodeView(frame: CGRect(x: margin + codeViewW + space        , y: codeViewY , width: codeViewW, height: codeViewW))
        codeView3 = SMSCodeView(frame: CGRect(x: margin + codeViewW * 2 + space * 2, y: codeViewY , width: codeViewW, height: codeViewW))
        codeView4 = SMSCodeView(frame: CGRect(x: margin + codeViewW * 3 + space * 3, y: codeViewY , width: codeViewW, height: codeViewW))
        self.view.addSubview(codeView1)
        self.view.addSubview(codeView2)
        self.view.addSubview(codeView3)
        self.view.addSubview(codeView4)
        
        
        resendLabel = UILabel(frame: CGRect(x: 0, y: screenH - keyboardHeight - 40, width: screenW, height: 40))
        resendLabel.text = "重新发送"
        resendLabel.font = UIFont(name: textFontName, size: 13)
        resendLabel.textColor = UIColor.colorFromRGB(rgbValue: 0x999999, alpha: 1)
        resendLabel.textAlignment = .center
        resendLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(SMSCodeViewController.resendSMS(_:)))
        resendLabel.addGestureRecognizer(tap)
    
        self.view.addSubview(resendLabel)
    }
    
    func keyboardWillAppear(_ notification: Notification){
        let keyboardInfo = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        keyboardHeight = (keyboardInfo as AnyObject).cgRectValue.size.height
        
        if !hasDraw {
            initView()
        }
        
        
    }
    
    func editingChanged() {
        
        let str = textfield.text!
        
        if str == "" {
            codeView1.text = ""
            codeView2.text = ""
            codeView3.text = ""
            codeView4.text = ""
            return
        }
        
        switch (str as NSString).length {
        case 1:
            codeView1.text = str
            codeView2.text = ""
            codeView3.text = ""
            codeView4.text = ""
        case 2:
            codeView1.text = str[0 ..< 1]
            codeView2.text = str[1 ..< 2]
            codeView3.text = ""
            codeView4.text = ""
        case 3:
            codeView1.text = str[0 ..< 1]
            codeView2.text = str[1 ..< 2]
            codeView3.text = str[2 ..< 3]
            codeView4.text = ""
        case 4:
            codeView1.text = str[0 ..< 1]
            codeView2.text = str[1 ..< 2]
            codeView3.text = str[2 ..< 3]
            codeView4.text = str[3 ..< 4]
            
            if str == smsCode {
                print("smsCode correct")
                self.codeCorrect()
            } else{
                print("smsCode error")
                self.codeError()
            }
            
        default:
            textfield.text = (str as String)[0 ..< 4]
        }
        
        
    }
    
    var time = 58
    func resendSMS(_ sender: UITapGestureRecognizer) {
        print("resend sms")
        resendLabel.text = "59"
        resendLabel.isUserInteractionEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target:self,selector: #selector(SMSCodeViewController.tickDown), userInfo:nil, repeats: true)
    }
    
    func tickDown() {
        if (time == 0) {
            timer?.invalidate()
            resendLabel.text = "重新发送"
            resendLabel.isUserInteractionEnabled = true
            time = 58
        } else {
            resendLabel.text = "\(time)"
        }
        
        time -= 1
        
    }
    
    func codeError() {
        
//        var style = ToastStyle()
//        style.backgroundColor = UIColor.colorFromRGB(0x666666, alpha: 1)
//        self.view.makeToast("CODE ERROR", duration: 1.0, position: CGPoint(x: self.view.bounds.size.width / 2.0, y: 50), style: style)
        
        
        UIView.animate(withDuration: 0.8, delay: 0.5, options: .curveLinear, animations: {
            
            self.codeView1.label.alpha = 0
            self.codeView2.label.alpha = 0
            self.codeView3.label.alpha = 0
            self.codeView4.label.alpha = 0
            
            }, completion: { _ in
                self.textfield.text = ""
                self.codeView1.text = ""
                self.codeView2.text = ""
                self.codeView3.text = ""
                self.codeView4.text = ""
                
                self.codeView1.label.alpha = 1
                self.codeView2.label.alpha = 1
                self.codeView3.label.alpha = 1
                self.codeView4.label.alpha = 1
        })

    }
    
    func codeCorrect() {
//        var style = ToastStyle()
//        style.backgroundColor = UIColor.colorFromRGB(0x666666, alpha: 1)
//        self.view.makeToast("CODE CORRECT", duration: 2.0, position: CGPoint(x: self.view.bounds.size.width / 2.0, y: 50), style: style)

    }
    
    
}


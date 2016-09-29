//
//  WebViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var wkWebView :WKWebView!
    var urlString = String()
    var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "新闻"
        initWKWebView()
        initProgressView()
        loadURL(urlString)
    }
    
    func initWKWebView() {
        wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.addSubview(wkWebView)
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    func initProgressView() {
        progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 5))
        progressView.backgroundColor = UIColor.clear
        self.view.addSubview(progressView)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath , keyPath == "estimatedProgress" {
            if wkWebView.estimatedProgress == 1 {
                progressView.isHidden = true
            } else {
                progressView.isHidden = false
                progressView.setProgress(Float(wkWebView.estimatedProgress), animated: true)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    func loadURL(_ url: String) {
        let url = URL(string: url)
        let urlRequest = URLRequest(url: url!)
        wkWebView.load(urlRequest)
    }
    
}

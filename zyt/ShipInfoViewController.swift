//
//  ShipInfoViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/11/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class ShipInfoViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ShipInfoViewController.close(_:)))
        gesture.cancelsTouchesInView = false
        gesture.delegate = self
        self.view.addGestureRecognizer(gesture)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    func initView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        routeButton.layer.cornerRadius = 10
        routeButton.layer.masksToBounds = true
        
        detailButton.layer.cornerRadius = 10
        detailButton.layer.masksToBounds = true
        
        navigationBar.barTintColor = UIColor.mainColor()
        routeButton.backgroundColor = UIColor.mainColor()
        detailButton.backgroundColor = UIColor.mainColor()
    }
    
    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func routeButtonTapped(_ sender: AnyObject) {
        print("routeButtonTapped")
    }
    @IBAction func detailButtonTapped(_ sender: AnyObject) {
        print("detailButtonTapped")
    }
    
}

extension ShipInfoViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BounceAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOutAnimationController()
    }
}

extension ShipInfoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}






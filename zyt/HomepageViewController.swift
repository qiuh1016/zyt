//
//  ViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit
import SDCycleScrollView

private var kGridViewMargin: CGFloat = 10

class HomepageViewController: UIViewController, SDCycleScrollViewDelegate {

    let titles = ["业务办理", "记录查询", "电子签证", "法律法规", "业务流程", "待办任务"]
    
    let imageUrls = [
        "http://www.cnfm.gov.cn/tpxwsyyzw/201607/W020160729535413736589.jpg",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/W020160613350121243228.jpg",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/W020160607311179962227.jpg",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201605/W020160530525181788332.jpg",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/W020160629399731306479.jpg"
    ]
    
    let imageTitles = [
        "学习习近平七一重要讲话加快推进渔业转型升级",
        "于康震：实现有质量的渔业转型升级发展",
        "水生生物增殖放流活动在全国范围同步举行",
        "中国秘鲁举行双边渔业会谈",
        "渔业渔政管理局开展定点扶贫村结对帮扶工作"
    ]
    
    let imageWebUrls = [
        "https://view.inews.qq.com/a/NEW201609100159180T",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201607/t20160729_5222942.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/t20160613_5167471.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/t20160607_5163334.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201605/t20160530_5154751.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/t20160629_5190352.htm"
    ]

    var cycleScrollView: SDCycleScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initSDCycleScrollView()
        initGridView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func initNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white] //, NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 18.0)!
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func initSDCycleScrollView() {
        cycleScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width * 200 / 375), delegate: self, placeholderImage: UIImage(named: "SDCycleViewDefaultImage"))
        cycleScrollView.imageURLStringsGroup = imageUrls
        cycleScrollView.titlesGroup = imageTitles
        cycleScrollView.autoScrollTimeInterval = 8
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        self.view.addSubview(cycleScrollView)
    }
    
    func initGridView() {
        
        if self.view.frame.height == 480 {
            kGridViewMargin = 20
        }
        let viewWidth = (view.bounds.width - 2 * kGridViewMargin - 4) / 3
        
        let contentGridView = UIView(frame: CGRect(x: kGridViewMargin, y: cycleScrollView.bounds.height + 0 + kGridViewMargin * 2, width: viewWidth * 3 + 4, height: viewWidth * 2 + 3))
        contentGridView.backgroundColor = UIColor.spaceLineColor()
        makeRoundedCorner(view: contentGridView, corners: .allCorners, cornerRadii: kOuterCornerRadii)
        if self.view.frame.height == 480 {
            contentGridView.center.y -= 35
        }
        self.view.addSubview(contentGridView)
        
        let serverGridView = GridView(frame: CGRect(x: 1, y: 1, width: viewWidth, height: viewWidth))
        serverGridView.image = UIImage(named: "homepage_service_2")
        serverGridView.text = titles[0]
        serverGridView.clickCallBack = { () -> () in
            self.performSegue(withIdentifier: "serviceSegue", sender: 0)
        }
        makeRoundedCorner(view: serverGridView, corners: .topLeft, cornerRadii: kInnerCornerRadii)
        contentGridView.addSubview(serverGridView)
        
        let recordGridView = GridView(frame: CGRect(x: 2 + viewWidth, y: 1, width: viewWidth, height: viewWidth))
        recordGridView.image = UIImage(named: "homepage_record_2")
        recordGridView.text = titles[1]
        recordGridView.clickCallBack = { () -> () in
            self.performSegue(withIdentifier: "serviceSegue", sender: 1)
        }
        contentGridView.addSubview(recordGridView)
        
        let visaGridView = GridView(frame: CGRect(x: 3 + 2 * viewWidth, y: 1, width: viewWidth, height: viewWidth))
        visaGridView.image = UIImage(named: "homepage_visa_2")
        visaGridView.text = titles[2]
        visaGridView.clickCallBack = { () -> () in
            self.performSegue(withIdentifier: "serviceSegue", sender: 2)
        }
        makeRoundedCorner(view: visaGridView, corners: .topRight, cornerRadii: kInnerCornerRadii)
        contentGridView.addSubview(visaGridView)
        
        let lawGridView = GridView(frame: CGRect(x: 1, y: 2 + viewWidth, width: viewWidth, height: viewWidth))
        lawGridView.image = UIImage(named: "homepage_law_2")
        lawGridView.text = titles[3]
        lawGridView.clickCallBack = { () -> () in
            self.performSegue(withIdentifier: "serviceSegue", sender: 3)
        }
        makeRoundedCorner(view: lawGridView, corners: .bottomLeft, cornerRadii: kInnerCornerRadii)
        contentGridView.addSubview(lawGridView)
        
        let processGridView = GridView(frame: CGRect(x: 2 + viewWidth, y: 2 + viewWidth, width: viewWidth, height: viewWidth))
        processGridView.image = UIImage(named: "homepage_process_2")
        processGridView.text = titles[4]
        processGridView.clickCallBack = { () -> () in
            self.performSegue(withIdentifier: "serviceSegue", sender: 4)
        }
        contentGridView.addSubview(processGridView)
        
        let todoGridView = GridView(frame: CGRect(x: 3 + 2 * viewWidth, y: 2 + viewWidth, width: viewWidth, height: viewWidth))
        todoGridView.image = UIImage(named: "homepage_todo_2")
        todoGridView.text = titles[5]
        todoGridView.clickCallBack = { () -> () in
            self.performSegue(withIdentifier: "serviceSegue", sender: 5)
        }
        makeRoundedCorner(view: todoGridView, corners: .bottomRight, cornerRadii: kInnerCornerRadii)
        contentGridView.addSubview(todoGridView)
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let vc = WebViewController()
        vc.urlString = imageWebUrls[index]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.show(vc, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "serviceSegue") {
            let vc = segue.destination as! ServiceViewController
            vc.index = sender as! Int
        }
    }
}





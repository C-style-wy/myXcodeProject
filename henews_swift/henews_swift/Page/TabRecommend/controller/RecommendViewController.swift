//
//  RecommendViewController.swift
//  henews_swift
//
//  Created by 汪洋 on 2017/1/4.
//  Copyright © 2017年 汪洋. All rights reserved.
//

import UIKit

class RecommendViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func initPage() {
        self.viewLayout()
    }
    
    override func initData() {
        
    }
    
    func viewLayout() {
        let topView = UIView()
        topView.backgroundColor = UIColor.white
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.height.equalTo(HeadHeight)
        }
        
        let line = UIImageView()
        line.image = UIImage(named: "menuFengexian")
        topView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.equalTo(topView).offset(0)
            make.left.equalTo(topView).offset(0)
            make.right.equalTo(topView).offset(0)
            make.height.equalTo(0.5)
        }
        
        let subView = UIView()
        subView.backgroundColor = clearColor
        topView.addSubview(subView)
        subView.snp.makeConstraints { (make) in
            make.edges.equalTo(topView).inset(UIEdgeInsetsMake(20, 0, 0, 0))
        }
    }
}

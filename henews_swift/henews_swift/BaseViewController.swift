//
//  BaseViewController.swift
//  henews_swift
//
//  Created by 汪洋 on 2016/10/24.
//  Copyright © 2016年 汪洋. All rights reserved.
//

import UIKit
let screenFrame = UIScreen.main.bounds
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPage()
        self.initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initPage() {
        self.view.backgroundColor = UIColor.white
        self.navigationController!.navigationBar.isHidden = true
    }
    
    func initData() {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

}

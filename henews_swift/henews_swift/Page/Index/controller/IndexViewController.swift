//
//  ViewController.swift
//  henews_swift
//
//  Created by 汪洋 on 2016/10/24.
//  Copyright © 2016年 汪洋. All rights reserved.
//

import UIKit

class IndexViewController: BaseViewController {
    // 懒加载，惰性存储属性
    lazy var bgImageView: UIImageView! = {
        [weak self] in
        var imageView: UIImageView?
        if let strongSelf = self {
            imageView = UIImageView(frame: strongSelf.view.bounds)
            strongSelf.view.addSubview(imageView!)
        }
        return imageView
    }()
    
//    private lazy var
    
    var time:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func initPage() {
        super.initPage()
        self.showLaunchImage()
    }
    
    override func initData() {
        super.initData()
        time = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { (Timer) in
            let tabBarPage: TabBarViewController! = TabBarViewController()
            tabBarPage.testBlock = {
                (str) in
                return str + "sb"
            }
            self.navigationController?.pushViewController(tabBarPage, animated: true)
            Timer.invalidate()
        })
    }
    
    // 设置背景启动图
    func showLaunchImage() {
        var imageName = iPhone5LaunchImage
        if IS_IPHONE4() {
            imageName = iPhone4LaunchImage
        } else if IS_IPHONE5() {
            imageName = iPhone5LaunchImage
        } else if IS_IPHONE6() {
            imageName = iPhone6LaunchImage
        } else if IS_IPHONE6P() {
            imageName = iPhone6pLaunchImage
        }
        bgImageView.image = UIImage(named: imageName)
    }
}


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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func initPage() {
        super.initPage()
        bgImageView.image = UIImage(named: "LaunchImage-700-568h")
    }
    
    override func initData() {
        super.initData()
    }
}


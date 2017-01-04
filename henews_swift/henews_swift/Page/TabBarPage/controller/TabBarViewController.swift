//
//  TabBarViewController.swift
//  henews_swift
//
//  Created by 汪洋 on 2016/12/8.
//  Copyright © 2016年 汪洋. All rights reserved.
//

import UIKit

class TabBarViewController: BaseViewController {
    var testBlock: ((String) -> (String))?
    // 懒加载，惰性存储属性
    lazy var menuView: UIView = {
        [weak self] in
        var view: UIView?
        if let strongSelf = self {
            view = UIView(frame: CGRect(x: 0, y: screenHeight-40, width: screenWidth, height: 40))
            view?.backgroundColor = UIColor.red
            strongSelf.view.addSubview(view!)
        }
        return view!
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func initPage() {
        super.initPage()
        print(self.testBlock!("哈哈"))
        menuView.backgroundColor = UIColor.gray
    }

}

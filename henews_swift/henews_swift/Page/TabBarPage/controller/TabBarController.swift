//
//  TabBarController.swift
//  henews_swift
//
//  Created by 汪洋 on 2017/1/3.
//  Copyright © 2017年 汪洋. All rights reserved.
//

import UIKit

let wTabBarH = CGFloat(40)*E2
let btnWidth = screenWidth / 5

class TabBarController: UITabBarController {
    
    // 选中的tabBar按钮
    var selectedBtn: TabBarButton?
    
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
    
    // tabBar view
    lazy var tabBarView: UIView = {
       [weak self] in
        var view: UIView?
        if let strongSelf = self {
            view = UIView()
            view!.backgroundColor = UIColor.white
            view!.frame = CGRect(x: 0, y: screenHeight-wTabBarH, width: screenWidth, height: wTabBarH)
            
            let line = UIImageView()
            line.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0.5)
            line.image = UIImage(named: "menuFengexian")
            view!.addSubview(line)
            
            strongSelf.view.addSubview(view!)
        }
        return view!
    }()
    
    // MARK:- 懒加载
    // 按钮的imageEdgeInsets
    lazy var imageEdgeInsetsArray:[UIEdgeInsets] = {
        var tempArray: [UIEdgeInsets] = [UIEdgeInsets]()
        tempArray.append(UIEdgeInsetsMake(4*E2, (btnWidth-22)/2, 18, (btnWidth-22)/2))
        tempArray.append(UIEdgeInsetsMake(4*E2, (btnWidth-16)/2, 18, (btnWidth-16)/2))
        tempArray.append(UIEdgeInsetsMake(4*E2, (btnWidth-18)/2, 18, (btnWidth-18)/2))
        tempArray.append(UIEdgeInsetsMake(4*E2, (btnWidth-18)/2, 18, (btnWidth-18)/2))
        tempArray.append(UIEdgeInsetsMake(4*E2, (btnWidth-16)/2, 18, (btnWidth-16)/2))
        return tempArray
    }()
    
    // MARK:- 懒加载
    // 按钮的imageEdgeInsets
    lazy var titleEdgeInsetsArray:[UIEdgeInsets] = {
        var tempArray: [UIEdgeInsets] = [UIEdgeInsets]()
        tempArray.append(UIEdgeInsetsMake(28*E2, -24.5, 6, 0))
        tempArray.append(UIEdgeInsetsMake(28*E2, -18, 6, 0))
        tempArray.append(UIEdgeInsetsMake(28*E2, -18, 6, 0))
        tempArray.append(UIEdgeInsetsMake(28*E2, -20, 6, 0))
        tempArray.append(UIEdgeInsetsMake(28*E2, -18, 6, 0))
        return tempArray
    }()
    
    // 按钮的tabBar title
    lazy var tabBarTitleArray:[String] = {
        var tempArray: [String] = [String]()
        tempArray.append("推荐")
        tempArray.append("资讯")
        tempArray.append("视界")
        tempArray.append("福利")
        tempArray.append("我的")
        return tempArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.createCustomTabBar()
        self.showLaunchImage()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (Timer) in
            UIView.animate(withDuration: 1.0, animations: {
                self.bgImageView.alpha = 0
                self.bgImageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            }, completion: { (Bool) in
                self.bgImageView.isHidden = true
            })
            
            Timer.invalidate()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 初始化
extension TabBarController {
    // MARK: 自定义TabBar
    func createCustomTabBar() {
        // 隐藏原有TabBar
        tabBar.isHidden = true
        
        for i in 0...4 {
            let btn = TabBarButton()
            let imageName = "menu" + String(i+1)
            let imageNameSel = "menusel" + String(i+1)
            
            btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
            btn.setImage(UIImage(named: imageNameSel), for: UIControlState.selected)
            let x = CGFloat(i) * btnWidth
            btn.frame = CGRect(x: x, y: 0, width: btnWidth, height: wTabBarH)
            if 0 == i {
                selectedBtn = btn
                btn.isSelected = true
            }
            
            btn.setTitle(tabBarTitleArray[i], for: UIControlState.normal)
            btn.imageEdgeInsets = imageEdgeInsetsArray[i]
            btn.titleEdgeInsets = titleEdgeInsetsArray[i]
        
            btn.titleLabel!.font = UIFont.systemFont(ofSize: 12)
            btn.setTitleColor(UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: UIControlState.normal)
            btn.setTitleColor(UIColor(red: 0.88, green: 0.02, blue: 0.46, alpha: 1), for: UIControlState.selected)
            btn.tag = i
            btn.addTarget(self, action: #selector(onClickBtn(sender:)) , for: UIControlEvents.touchUpInside)
            self.tabBarView.addSubview(btn)
        }
        let recommend = RecommendViewController()
        let information = InformationViewController()
        let viewPoint = ViewPointViewController()
        let welfare = WelfareViewController()
        let my = MyViewController()
        
        self.viewControllers = [recommend, information, viewPoint, welfare, my]
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

// MARK:- 事件监听
extension TabBarController {
    func onClickBtn(sender:UIButton!) {
        if sender == selectedBtn {
            
        }else{
            selectedBtn!.isSelected = false
            sender!.isSelected = true
            selectedBtn = sender as! TabBarButton!
            self.selectedIndex = sender.tag
        }
    }
}

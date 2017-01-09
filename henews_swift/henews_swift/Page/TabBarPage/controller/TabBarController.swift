//
//  TabBarController.swift
//  henews_swift
//
//  Created by 汪洋 on 2017/1/3.
//  Copyright © 2017年 汪洋. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

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
    
    lazy var tabBarView: UIView = {
       [weak self] in
        var view: UIView?
        if let strongSelf = self {
            view = UIView()
            view!.backgroundColor = UIColor.white
            view!.frame = CGRect(x: 0, y: screenHeight-TabBarHeight, width: screenWidth, height: TabBarHeight)
            
            let line = UIImageView()
            line.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0.5)
            line.image = UIImage(named: "menuFengexian")
            view!.addSubview(line)
            
            strongSelf.view.addSubview(view!)
        }
        return view!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.tabBar.isHidden = true
        
        self.addMenuView()
        
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
    
    func addMenuView() {
        for i in 0...4 {
            let btn = TabBarButton()
            let imageName = "menu" + String(i+1)
            let imageNameSel = "menusel" + String(i+1)
            
            btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
            btn.setImage(UIImage(named: imageNameSel), for: UIControlState.selected)
            let btnWidth = screenWidth / 5
            let x = CGFloat(i) * btnWidth
            btn.frame = CGRect(x: x, y: 0, width: btnWidth, height: TabBarHeight)
            switch i {
            case 0:
                selectedBtn = btn
                btn.setTitle("推荐", for: UIControlState.normal)
                btn.imageEdgeInsets = UIEdgeInsetsMake(4*E2, (btnWidth-22)/2, 18, (btnWidth-22)/2)
                btn.titleEdgeInsets = UIEdgeInsetsMake(28*E2, -24.5, 6, 0)
                btn.isSelected = true
                break
            case 1:
                btn.setTitle("资讯", for: UIControlState.normal)
                btn.imageEdgeInsets = UIEdgeInsetsMake(4*E2, (btnWidth-16)/2, 18, (btnWidth-16)/2)
                btn.titleEdgeInsets = UIEdgeInsetsMake(28*E2, -18, 6, 0)
                break
            case 2:
                btn.setTitle("视界", for: UIControlState.normal)
                btn.imageEdgeInsets = UIEdgeInsetsMake(4*E2, (btnWidth-18)/2, 18, (btnWidth-18)/2)
                btn.titleEdgeInsets = UIEdgeInsetsMake(28*E2, -18, 6, 0)
                break
            case 3:
                btn.setTitle("福利", for: UIControlState.normal)
                btn.imageEdgeInsets = UIEdgeInsetsMake(4*E2, (btnWidth-18)/2, 18, (btnWidth-18)/2)
                btn.titleEdgeInsets = UIEdgeInsetsMake(28*E2, -20, 6, 0)
                break
            case 4:
                btn.setTitle("我的", for: UIControlState.normal)
                btn.imageEdgeInsets = UIEdgeInsetsMake(4*E2, (btnWidth-16)/2, 18, (btnWidth-16)/2)
                btn.titleEdgeInsets = UIEdgeInsetsMake(28*E2, -18, 6, 0)
                break
            default: break
            }
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
    
    func onClickBtn(sender:UIButton!) {
        if sender == selectedBtn {
            
        }else{
            selectedBtn!.isSelected = false
            sender!.isSelected = true
            selectedBtn = sender as! TabBarButton!
            self.selectedIndex = sender.tag
        }
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

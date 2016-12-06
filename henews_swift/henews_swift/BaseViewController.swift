//
//  BaseViewController.swift
//  henews_swift
//
//  Created by 汪洋 on 2016/10/24.
//  Copyright © 2016年 汪洋. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPage()
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    //设置当前ViewController的StatusBar的样式
//    func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .default
//    }
//    //隐藏还是展示statusBar
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
//    //statusBar的改变动画
//    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
//        return .Fade  
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

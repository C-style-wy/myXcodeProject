//
//  MacroDefinition.swift
//  henews_swift
//
//  Created by 汪洋 on 2016/12/6.
//  Copyright © 2016年 汪洋. All rights reserved.
//

import Foundation
import UIKit

let screenFrame = UIScreen.main.bounds
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

func IS_IPHONE4() -> Bool {
    return UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 640, height: 960), (UIScreen.main.currentMode?.size)!) : false
}
func IS_IPHONE5() -> Bool {
    return UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 640, height: 1136), (UIScreen.main.currentMode?.size)!) : false
}
func IS_IPHONE6() -> Bool {
    return UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? (__CGSizeEqualToSize(CGSize(width: 750, height: 1334), (UIScreen.main.currentMode?.size)!) || __CGSizeEqualToSize(CGSize(width: 640, height: 1136), (UIScreen.main.currentMode?.size)!)) : false
}
func IS_IPHONE6P() -> Bool {
    return UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1242, height: 2208), (UIScreen.main.currentMode?.size)!) : false
}

let iPhone4LaunchImage = "LaunchImage-700"
let iPhone5LaunchImage = "LaunchImage-700-568h"
let iPhone6LaunchImage = "LaunchImage-800-667h"
let iPhone6pLaunchImage = "LaunchImage-800-Portrait-736h"

let E1 = screenWidth/320.0
let E2 = min(screenWidth, screenHeight)/min(320, 568)
let E3 = screenHeight/568
let E4 = screenHeight/320

let TabBarHeight = CGFloat(40)*E2
let HeadHeight = CGFloat(53)*E2

// 颜色
let clearColor = UIColor.clear

func IS_IOS7() ->Bool {return (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0}

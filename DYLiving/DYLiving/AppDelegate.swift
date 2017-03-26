//
//  AppDelegate.swift
//  DYLiving
//
//  Created by 黑色o.o表白 on 2017/3/22.
//  Copyright © 2017年 黑色o.o表白. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //同意修改tabbar风格颜色
        UITabBar.appearance().tintColor = UIColor.orange
        return true
    }

    

}


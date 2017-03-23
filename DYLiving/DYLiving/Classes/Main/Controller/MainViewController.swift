//
//  MainViewController.swift
//  DYLiving
//
//  Created by 黑色o.o表白 on 2017/3/23.
//  Copyright © 2017年 黑色o.o表白. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Find")
        addChildVC(storyName: "Profile")
        
    }
    
    private func addChildVC(storyName:String){
        //1.通过storyboard获取控制器
        let childVC = UIStoryboard(name:storyName,bundle:nil).instantiateInitialViewController()!
        //2.将childVC作为子控制器
        addChildViewController(childVC)
    }

}

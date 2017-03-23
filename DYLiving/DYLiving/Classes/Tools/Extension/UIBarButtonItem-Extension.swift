//
//  UIBarButtonItem-Extension.swift
//  DYLiving
//
//  Created by 黑色o.o表白 on 2017/3/23.
//  Copyright © 2017年 黑色o.o表白. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName : String, highImageName: String,size :CGSize) ->UIBarButtonItem{
    
        let Btn = UIButton()
        Btn.setImage(UIImage(named:imageName), for: .normal)
        Btn.setImage(UIImage(named:highImageName), for: .highlighted)
        Btn.frame = CGRect(origin:CGPoint(x:0,y:0) ,size:size)
        let btnItem = UIBarButtonItem(customView:Btn)
        
        return btnItem
    }
    */
    //遍历构造函数 1>convenience开头 2>在构造函数中必须调用一个设计的构造函数
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize(width:0,height:0)) {
        
        let Btn = UIButton()
        Btn.setImage(UIImage(named:imageName), for: .normal)
        if highImageName != "" {
            Btn.setImage(UIImage(named:highImageName), for: .highlighted)
        }
        if size == CGSize(width:0,height:0){
            Btn.sizeToFit()
        }else{
        Btn.frame = CGRect(origin:CGPoint(x:0,y:0) ,size:size)
        }
        
        self.init(customView:Btn)
        
    }
    
}

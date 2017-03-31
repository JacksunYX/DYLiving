//
//  NetworkTool.swift
//  DYLiving
//
//  Created by 黑色o.o表白 on 2017/3/31.
//  Copyright © 2017年 黑色o.o表白. All rights reserved.
//

import UIKit
import Alamofire
//定义枚举
enum MethodType{
    case GET
    case POST
}

class NetworkTool {
    //封装网络请求方法
    class func requestData(type : MethodType,URLString : String,paramters : [String : AnyObject]? = nil, finishedCallback : @escaping (_ result : AnyObject) -> ()){
        
        //1.获取请求方式
        let method = type == .GET ? Alamofire.HTTPMethod.get : Alamofire.HTTPMethod.post
        //2.发送网络请求
        Alamofire.request(URLString, method: method,parameters: paramters).responseJSON { (response) in
            
            guard let result = response.result.value else {
                //打印信息
                print(response.result.error)
                return
            }
            finishedCallback(result as AnyObject)
        }
        
    }
}

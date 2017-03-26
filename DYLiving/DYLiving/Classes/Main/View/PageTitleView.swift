//
//  PageTitleView.swift
//  DYLiving
//
//  Created by 黑色o.o表白 on 2017/3/23.
//  Copyright © 2017年 黑色o.o表白. All rights reserved.
//

import UIKit

//表示协议只能被类遵守
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView : PageTitleView,selectedIndex index : Int)
}

//定义常量
let sScrollLineH : CGFloat = 4
let sNormalColor : (CGFloat , CGFloat , CGFloat) = (85,85,85)
let sSelectColor : (CGFloat , CGFloat , CGFloat) = (255,128,0)


class PageTitleView: UIView {
    
    //定义属性
    var titles:[String]
    //保存所有已设置过的的label
    lazy var titleLabelsArr : [UILabel] = [UILabel]()
    
    var currentIndex : NSInteger = 0
    
    weak var delegate: PageTitleViewDelegate?
    
    //懒加载滚动视图
    lazy var scrollView : UIScrollView = {
        
        let scrollview = UIScrollView()
        scrollview.scrollsToTop = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.bounces = false
        return scrollview
        
    }()
    
    //懒加载滑块
    lazy var scrollLine:UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    
    }()
    
    //自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles;
        
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//设置UI界面
extension PageTitleView{
    
    //设置UI
    func setupUI(){
        //1.添加滚动视图
        addSubview(scrollView)
        scrollView.frame = bounds
        //2.添加title对应的label
        setupTitleLabels()
        //3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
        
        
    }
    
    //添加title对应的label
    func setupTitleLabels(){
        
        let labelW : CGFloat = frame.width/CGFloat(titles.count)
        let labelH : CGFloat = frame.height - sScrollLineH
        let labelY : CGFloat = 0
        
        
        for (index, title) in titles.enumerated() {
            //1.创建label
            let label  = UILabel()
            label.tag = index
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r:sNormalColor.0 ,g:sNormalColor.1,b:sNormalColor.2)
            label.textAlignment = .center
            
            //2.设置label的frame
            let labelX :CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //3. 添加到滚动视图上
            scrollView.addSubview(label)
            
            titleLabelsArr.append(label)
            
            //4.给label添加点击效果
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
        
    }
    
    //添加底线和滑块
    func setupBottomLineAndScrollLine(){
        
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //获取第一个label
        guard let firstLabel = titleLabelsArr.first else {
            return
        }
        firstLabel.textColor = UIColor(r: sSelectColor.0, g: sSelectColor.1, b: sSelectColor.2)
        
        //2.添加滑块
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-sScrollLineH, width: firstLabel.frame.width, height:sScrollLineH)
        
    }
    
    
}

//监听label点击回调
extension PageTitleView{

    @objc func titleLabelClick(tapGes : UITapGestureRecognizer){
    
        //1.先得到当前label
        guard let currentLabel = tapGes.view as?UILabel else {
            return
        }
    
        //2.获取之前的label
        let oldLabel  = titleLabelsArr[currentIndex]
        //3.切换颜色
        oldLabel.textColor = UIColor(r:sNormalColor.0 ,g:sNormalColor.1,b:sNormalColor.2)
        currentLabel.textColor = UIColor(r: sSelectColor.0, g: sSelectColor.1, b: sSelectColor.2)
        
        //4.保存最新label的下标
        currentIndex = currentLabel.tag
        
        //5.滚动条位置发生变化
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) {
            
            self.scrollLine.frame.origin.x = scrollLineX
            
        }
        //通知代理执行协议方法
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }

}

//对外暴露方法
extension PageTitleView {

    func setTitleWithProgress(progress : CGFloat ,sourceIndex : Int ,targetIndex : Int){
    
        //1.取出sourceLabel和targetLabel
        let sourceLabel = titleLabelsArr[sourceIndex]
        let targetLabel = titleLabelsArr[targetIndex]
        
        //2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        }
        
        //3.颜色渐变
        //计算三色的变化范围
        let colorDelta = (sSelectColor.0 - sNormalColor.0,sSelectColor.1 - sNormalColor.1,sSelectColor.2 - sNormalColor.2)
        let changeR : CGFloat = colorDelta.0 * progress
        let changeG : CGFloat = colorDelta.1 * progress
        let changeB : CGFloat = colorDelta.2 * progress
        
        //由深色变为浅色，使用减法
        sourceLabel.textColor = UIColor(r: sSelectColor.0 - changeR, g: sSelectColor.1 - changeG, b: sSelectColor.2 - changeB)
        //由浅变深，使用加法
        targetLabel.textColor = UIColor(r: sNormalColor.0 + changeR, g: sNormalColor.1 + changeG, b: sNormalColor.2 + changeB)
        
        //4.记录最新的index
        currentIndex = targetIndex
        
    }

}










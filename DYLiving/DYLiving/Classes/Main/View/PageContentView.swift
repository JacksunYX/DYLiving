//
//  PageContentView.swift
//  DYLiving
//
//  Created by 黑色o.o表白 on 2017/3/23.
//  Copyright © 2017年 黑色o.o表白. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate :class {
    
    func pageContentView(contentView : PageContentView ,progress : CGFloat,sourceIndex : Int,targetIndex : Int)
    
}

let ContentCellID = "PageContentViewCell"


class PageContentView: UIView {
    
    //定义属性
    var childVcs :[UIViewController]
    weak var parentViewController: UIViewController?
    weak var delegate : PageContentViewDelegate?
    var startOffset : CGFloat  = 0
    var isForbidScrollDelegate : Bool = false
    
    //懒加载collectionView
    lazy var collectionView :UICollectionView = {[weak self] in
    
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建collectionView
        let collectView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectView.showsVerticalScrollIndicator = false
        collectView.isPagingEnabled = true
        collectView.bounces = false
        collectView.dataSource = self
        collectView.delegate = self
        collectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectView
    }()
    
    //自定义构造函数
    init(frame: CGRect ,childVcs:[UIViewController],parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame:frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//设置UI界面
extension PageContentView{

    func setupUI(){
    
        //1.把所有的子控制器放到父控制器上进行管理
        for childVc in childVcs {
            
            parentViewController?.addChildViewController(childVc)
            childVc.view.frame = self.frame
            
        }
        //2.添加collectionView,用来存放子控制器
        addSubview(collectionView)
        collectionView.frame = bounds
    
    }

}

//UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVcs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let  childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
        
    }

}

//遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        //当使用手指滑动时，设置为false
        isForbidScrollDelegate = false
        //纪录下手指放在屏幕上马上要开始滑动时的偏移量
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //如果为true则直接返回，防止重复调用代理方法
        if isForbidScrollDelegate {return}
        //1.定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2.判断是左滑还是右滑
        let currentOffset :CGFloat = scrollView.contentOffset.x
        let scrollViewW : CGFloat = scrollView.bounds.width
        
        if currentOffset > startOffset {    //左滑
            //使用floor函数取整，然后相减得到正确的比例
            progress = currentOffset/scrollViewW - floor(currentOffset/scrollViewW)
            sourceIndex = Int(currentOffset/scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            
            //如果完全滑过去，需要将progress设置为1，sourceIndex和targetIndex相等
            if currentOffset - startOffset == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        
        }else{  //右滑
            //跟上面相反，需要用1来减
            progress = 1 - (currentOffset/scrollViewW - floor(currentOffset/scrollViewW))
            sourceIndex = Int(currentOffset/scrollViewW) + 1
            if currentOffset <= 0 {
                sourceIndex = 0
            }
            targetIndex = Int(currentOffset/scrollViewW)
            
        }
        
        //3.将三个参数传递给titleView
        //print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }

}

//对外暴露方法
extension PageContentView {

    func setOffset(currentOffset:Int){
        
        //1.记录
        isForbidScrollDelegate = true
        //2.滚到正确的位置
        collectionView.setContentOffset(CGPoint(x:collectionView.frame.width * CGFloat(currentOffset), y: 0), animated: true)
    
    }

}







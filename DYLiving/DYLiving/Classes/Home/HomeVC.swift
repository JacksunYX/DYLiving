//
//  HomeVC.swift
//  DYLiving
//
//  Created by 黑色o.o表白 on 2017/3/23.
//  Copyright © 2017年 黑色o.o表白. All rights reserved.
//

import UIKit

let sTitleViewH: CGFloat = 40

class HomeVC: UIViewController {
    
    //懒加载
    public lazy var pageTitleView : PageTitleView = {[weak self] in
    
        let titleFrame = CGRect(x:0,y:64,width:sScreenW,height:sTitleViewH)
        let titles = ["推荐","手游","娱乐","游戏","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
        
    }()
    
    lazy var pageContentView : PageContentView = {[weak self] in
        //计算将要添加的contentView的frame
        let contentH = sScreenH - sStatusBarH - sNavigationBar - sTitleViewH
        let contetFrame = CGRect(x: 0, y: sStatusBarH + sNavigationBar + sTitleViewH, width: sScreenW, height: contentH)
        
        //创建viewController，并保存到数组里
        var childVcs = [UIViewController]()
        for _ in 0..<5 {
        
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contetFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
    }

}

//设置ui界面
extension HomeVC{
    //设置ui
    public func setupUI() {
        
        //0.不需要调整内边距 
        automaticallyAdjustsScrollViewInsets = false
    
        //1.设置导航栏
        setupNavigationBar()
    
        //2.添加TitleView
        view.addSubview(pageTitleView)
        
        //3.添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    
    //设置导航栏
    private func setupNavigationBar(){
        //左侧logo
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "homeLogoIcon")
        //导航栏颜色风格
        navigationController?.navigationBar.barTintColor = UIColor.orange
        //右侧的按钮
        //浏览历史
        let size = CGSize(width:40,height:40)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        //游戏中心
        let gamesCenterItem = UIBarButtonItem(imageName: "home_newGameicon", highImageName: "home_newGameicon", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,gamesCenterItem]
        
    }
}

//遵守PageTitleViewDelegate协议
extension HomeVC : PageTitleViewDelegate {

    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        
        //pageContentView.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .right, animated: true)
        self.pageContentView.setOffset(currentOffset: index)
        
    }

}

//遵守PageContentViewDelegate协议
extension HomeVC : PageContentViewDelegate {

    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //调用暴露在外的方法改变TitleView
        self.pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }

}














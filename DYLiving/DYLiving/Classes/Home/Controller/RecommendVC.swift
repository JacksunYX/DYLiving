//
//  RecommendVC.swift
//  DYLiving
//
//  Created by 黑色o.o表白 on 2017/3/25.
//  Copyright © 2017年 黑色o.o表白. All rights reserved.
//

import UIKit

let sCellMargin : CGFloat = 10
let sNormalCellW = (sScreenW - 3 * sCellMargin)/2
let sNormalCellH = (sNormalCellW) * 3 / 4
let sPrettyCellH = (sNormalCellW) * 4 / 3
let sCollectionViewHeadH : CGFloat = 50

let sCollcetionViewHeadViewID = "sCollcetionViewHeadViewID"
let sNormaelCellID = "sNormaelCellID"
let sPrettyCellID = "sPrettyCellID"






class RecommendVC: UIViewController {
    //懒加载collectionView
    lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: sNormalCellW, height: sNormalCellH)
        layout.minimumLineSpacing = 5.0 //行间距为0（根据需要）
        layout.minimumInteritemSpacing = sCellMargin //cell间的最小间距
        layout.headerReferenceSize = CGSize(width: sScreenW, height: sCollectionViewHeadH)
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10) //设置缩进
        
        //2.创建collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: HomeCenterViewH), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        //需要将collectionView自动适应父视图的大小
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleWidth]
        //3.注册collectionCell
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: sNormaelCellID)
        //普通cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: sNormaelCellID)
        //颜值cell
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: sPrettyCellID)
        //4.注册组头
        //collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sCollcetionViewHeadViewID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sCollcetionViewHeadViewID)
        
        return collectionView
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置界面
        setupUI()
        //求请数据
        loadData()
        
    }
    
    

}

//设置UI界面xr
extension RecommendVC {

    func setupUI(){
        
        view.addSubview(collectionView)
        
    }

}

//请求数据
extension RecommendVC {

    func loadData (){
        
        NetworkTool.requestData(type: .GET, URLString: "http://httpbin.org/get") { (respose) in
            
            print(respose)
            
        }
        
    }

}

//遵循collectionView协议
extension RecommendVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell :UICollectionViewCell
        
        if indexPath.section == 1 { //颜值区
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: sPrettyCellID, for: indexPath)
        }else{
        //普通cell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: sNormaelCellID, for: indexPath)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sCollcetionViewHeadViewID, for: indexPath)
        
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 { //颜值区
            return CGSize(width: sNormalCellW, height: sPrettyCellH)
        }
        return CGSize(width: sNormalCellW, height: sNormalCellH)
    }

}












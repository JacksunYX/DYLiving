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
let sCollectionViewHeadH : CGFloat = 50

let sNormaelCellID = "sNormaelCellID"
let sCollcetionViewHeadViewID = "sCollcetionViewHeadViewID"






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
        collectionView.backgroundColor = UIColor.white
        //需要将collectionView自动适应父视图的大小
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleWidth]
        //3.注册collectionCell
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: sNormaelCellID)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: sNormaelCellID)
        //4.注册组头
        //collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sCollcetionViewHeadViewID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sCollcetionViewHeadViewID)
        
        return collectionView
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置界面
        setupUI()
        
    }
    
    

}

//设置UI界面xr
extension RecommendVC {

    func setupUI(){
        
        view.addSubview(collectionView)
        
    }

}

//遵循collectionView协议
extension RecommendVC : UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sNormaelCellID, for: indexPath)
        //cell.backgroundColor = UIColor.red
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sCollcetionViewHeadViewID, for: indexPath)
        
        return headView
    }

}












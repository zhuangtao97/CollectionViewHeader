//
//  ViewController.swift
//  UIConnectionView_01
//
//  Created by zhuangtao on 2017/8/10.
//  Copyright © 2017年 zhuangtao. All rights reserved.
//

import UIKit

class ViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var collectionVIew:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = ASMflowlayout.init()
        
//        flowLayout.itemSize = self.view.bounds.size
        
        flowLayout.headerReferenceSize = CGSize.init(width: self.view.bounds.size.width, height: 30)
        
        self.collectionVIew = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        
        self.collectionVIew!.backgroundColor = UIColor.blue
        
        self.view.addSubview(self.collectionVIew!)
        
        self.collectionVIew?.delegate = self;
        self.collectionVIew?.dataSource = self;
        
        
        let head = UICollectionReusableView.init()
        
        head.backgroundColor = UIColor.red
        
        let item = UICollectionViewCell.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        self.collectionVIew?.register(head.classForCoder, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        self.collectionVIew?.register(item.classForCoder, forCellWithReuseIdentifier: "itemcell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusable:UICollectionReusableView?
        
        
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView = (collectionVIew?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath))!
            headerView.backgroundColor = UIColor.yellow
            reusable = headerView
            
        }
        
        return reusable!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "itemcell", for: indexPath)
        
        item.backgroundColor = UIColor.white
        return  item
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: self.view.bounds.size.width, height: 30)
    }

}


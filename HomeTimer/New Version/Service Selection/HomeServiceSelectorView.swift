//
//  HomeServiceSelectorView.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit
import HomeKit

enum ServiceSelection {
    case unselected
    case off
    case on
}

struct ServiceCellItem {
    let title: String
    let status: ServiceSelection
    
    init(title: String, status: ServiceSelection = .unselected) {
        self.title = title
        self.status = status
    }
}

class HomeServiceSelectorView: XibView, UICollectionViewDataSource, UICollectionViewDelegate {
    var numCells = 0
    
    let cellItems: [ServiceCellItem] = [
        .init(title: "One", status: .unselected),
        .init(title: "Two", status: .off),
        .init(title: "Three", status: .on),
        .init(title: "Four"),
        .init(title: "Five"),
    ]
    
    @IBOutlet var collectionView: UICollectionView? {
        didSet {
            guard let collectionView = collectionView else { return }
            collectionView.register(UINib(nibName: "HomeServiceCollectionViewCell", bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: "Cell")
            let layout: UICollectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            
            let spacing: CGFloat = 10
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            layout.minimumLineSpacing = spacing
            
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView?.layoutSubviews()
        
        guard let collectionView = collectionView, let layout: UICollectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        layout.itemSize = CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeServiceCollectionViewCell
        
        let cellItem = cellItems[indexPath.row]
        
        cell.label.text = cellItem.title
        cell.setStatus(status: cellItem.status)
        
        
        return cell
    }
    
    
}
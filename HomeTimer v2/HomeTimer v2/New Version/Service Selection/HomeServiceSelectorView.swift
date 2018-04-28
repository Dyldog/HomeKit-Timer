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
    
    var asBool: Bool? {
        switch self {
        case .unselected: return nil
        case .off: return false
        case .on: return true
        }
    }
}

extension Bool {
    var asServiceState: ServiceSelection {
        switch self {
        case true: return .on
        case false: return .off
        }
    }
}

struct ServiceCellItem {
    let title: String
    let status: ServiceSelection
    
    init(title: String, status: ServiceSelection = .unselected) {
        self.title = title
        self.status = status
    }
}

protocol HomeServiceSelectorViewDelegate {
    func homeServiceSelectorView(_ serviceSelectorView: HomeServiceSelectorView, didSelectServiceAt index: Int)
}

class HomeServiceSelectorView: XibView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var delegate: HomeServiceSelectorViewDelegate?
    
    var cellItems: [ServiceCellItem] = []
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.homeServiceSelectorView(self, didSelectServiceAt: indexPath.row)
    }
    
    func reloadData() {
        collectionView?.reloadData()
    }
    
    func reloadItems(at indexes: [Int]) {
        collectionView?.reloadItems(at: indexes.map { IndexPath(row: $0, section: 0) })
    }
    
    func set(selectionEnabled: Bool) {
        collectionView?.allowsSelection = selectionEnabled
    }
    
}

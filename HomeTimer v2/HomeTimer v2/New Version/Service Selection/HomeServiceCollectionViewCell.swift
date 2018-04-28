//
//  HomeServiecCollectionViewCell.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit

class HomeServiceCollectionViewCell: UICollectionViewCell {

    @IBOutlet var label: UILabel!
    @IBOutlet var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.borderWidth = 2
    }
    
    func setStatus(status: ServiceSelection) {
        switch status {
        case .unselected:
            bgView.backgroundColor = .gray
            label.textColor = .darkGray
            bgView.layer.borderColor = UIColor.clear.cgColor
        case .on:
            bgView.backgroundColor = .white
            label.textColor = .black
            bgView.layer.borderColor = UIColor.darkGray.cgColor
        case .off:
            bgView.backgroundColor = .white
            label.textColor = .gray
            bgView.layer.borderColor = UIColor.gray.cgColor
        }
    }

}

//
//  HomeServiecCollectionViewCell.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit

class HomeServiceCollectionViewCell: UICollectionViewCell {

    @IBOutlet var roomNameLabel: UILabel!
    @IBOutlet var serviceNameLabel: UILabel!
    @IBOutlet var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.borderWidth = 2
    }
    
    func styleLabel(_ label: UILabel, forStatus status: ServiceSelection) {
        switch status {
        case .unselected: label.textColor = .darkGray
        case .on: label.textColor = .black
        case .off: label.textColor = .white
        }
    }
    
    func setStatus(status: ServiceSelection) {
        switch status {
        case .unselected:
            bgView.backgroundColor = .gray
            bgView.layer.borderColor = UIColor.clear.cgColor
        case .on:
            bgView.backgroundColor = .white
            bgView.layer.borderColor = UIColor.darkGray.cgColor
        case .off:
            bgView.backgroundColor = .black
            bgView.layer.borderColor = UIColor.clear.cgColor
        }
        
        styleLabel(roomNameLabel, forStatus: status)
        styleLabel(serviceNameLabel, forStatus: status)
    }

}

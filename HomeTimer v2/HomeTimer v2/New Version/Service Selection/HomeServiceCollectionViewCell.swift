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
    }
    
    func setStatus(status: ServiceSelection) {
        switch status {
        case .unselected:
            self.bgView.backgroundColor = .gray
            self.label.textColor = .darkGray
        case .on:
            self.bgView.backgroundColor = .white
            self.label.textColor = .black
        case .off:
            self.bgView.backgroundColor = .white
            self.label.textColor = .gray
        }
    }

}

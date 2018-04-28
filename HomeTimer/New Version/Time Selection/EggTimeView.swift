//
//  EggTimeView.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit

class EggTimeView: XibView, UIScrollViewDelegate {
    @IBInspectable var numberWidth: CGFloat = 20 {
        didSet { initializeScrollView() }
    }
    
    @IBInspectable var numberSpacing: CGFloat = 20 {
        didSet { initializeScrollView() }
    }
    
    @IBInspectable var numberColor: UIColor = .black {
        didSet { initializeScrollView() }
    }
    
    @IBInspectable var numberFontSize: Int = 48 {
        didSet { initializeScrollView() }
    }
    
    @IBInspectable var lineWidth: CGFloat = 10 {
        didSet { initializeScrollView() }
    }
    
    @IBInspectable var lineHeight: CGFloat = 20 {
    didSet { initializeScrollView() }
    }
    
    @IBInspectable var lineColor: UIColor = .black {
        didSet { initializeScrollView() }
    }
    
    @IBOutlet var scrollView: UIScrollView? {
        didSet {
            initializeScrollView()
        }
    }
    
    func initializeScrollView() {
        guard let scrollView = scrollView else { return }
        
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        var previousNumberLabel: UILabel?
        
        (0...10).forEach { index in
            let numberLabel = UILabel()
            numberLabel.text = String(index)
            numberLabel.textAlignment = .center
            numberLabel.font = UIFont.systemFont(ofSize: CGFloat(numberFontSize))
            numberLabel.textColor = numberColor
            
            numberLabel.sizeToFit()
            numberLabel.frame.size.width = numberWidth
            numberLabel.frame.origin.y = self.frame.height - numberLabel.frame.height
            
            //numberLabel.backgroundColor = .blue
            
            
            if let previousNumberLabel = previousNumberLabel {
                numberLabel.frame.origin.x = previousNumberLabel.center.x + numberSpacing + numberLabel.frame.width / 2.0
            } else {
                numberLabel.frame.origin.x = 0
            }
            
            
            scrollView.addSubview(numberLabel)
            
            let lineView = UIView(frame: CGRect(x: numberLabel.frame.maxX + numberSpacing / 2.0 - lineWidth / 2.0, y: 0, width: lineWidth, height: lineHeight))
            lineView.backgroundColor = lineColor
            lineView.frame.origin.y = self.frame.height - lineView.frame.height
            scrollView.addSubview(lineView)
            
            previousNumberLabel = numberLabel
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let scrollView = scrollView else { return }
        
        scrollView.contentSize.width = scrollView.subviews.map { $0.frame.maxX }.max() ?? 0
    }
}

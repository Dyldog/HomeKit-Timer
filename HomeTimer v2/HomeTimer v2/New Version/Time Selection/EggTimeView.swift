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
    
    var maxValue: Int = 10
    var numPips = 1
    
    func initializeScrollView() {
        guard let scrollView = scrollView else { return }
        
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        var previousNumberLabel: UILabel?
        let xOffset = scrollView.frame.size.width / 2.0
        
        (0...maxValue).forEach { index in
            let numberLabel = UILabel()
            numberLabel.text = String(index)
            numberLabel.textAlignment = .center
            numberLabel.font = UIFont.systemFont(ofSize: CGFloat(numberFontSize))
            numberLabel.textColor = numberColor
            
            numberLabel.sizeToFit()
            numberLabel.frame.origin.y = scrollView.frame.height - numberLabel.frame.height
            
            // numberLabel.backgroundColor = .blue
            
            
            if let previousNumberLabel = previousNumberLabel {
                numberLabel.center.x = previousNumberLabel.center.x + numberSpacing
            } else {
                numberLabel.center.x = 0
            }
            
            scrollView.addSubview(numberLabel)
            
            let lineView = UIView(frame: CGRect(x: 0, y: 0, width: lineWidth, height: lineHeight))
            lineView.center.x = numberLabel.center.x + numberSpacing / 2.0
            lineView.backgroundColor = lineColor
            lineView.frame.origin.y = scrollView.frame.height - lineView.frame.height
            scrollView.addSubview(lineView)
            
            previousNumberLabel = numberLabel
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: xOffset, bottom: 0, right: xOffset)
            scrollView.contentSize.width = (scrollView.subviews.map { $0.center.x }.max() ?? 0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        initializeScrollView()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let correctedOffset = targetContentOffset.pointee.x + scrollViewXInset
        let index = CGFloat(indexForCorrectedOffset(offset: correctedOffset))
        targetContentOffset.pointee.x = index * scrollViewPageSize - scrollViewXInset
    }
    
    func indexForCorrectedOffset(offset: CGFloat) -> Int {
        let scrollView = self.scrollView!
        
        let targetX = offset
        
        let index = round(CGFloat(numPages) * targetX / scrollView.contentSize.width).clamp(lower: 0, upper: CGFloat(numPages))
        
        return Int(index)
    }
    
    var scrollViewXInset: CGFloat {
        return scrollView!.contentInset.left
    }
    
    var scrollViewPageSize: CGFloat {
        return scrollView!.contentSize.width / CGFloat(numPages)
    }
    
    var numPages: Int {
        return (1 + numPips) * (maxValue + 1) - 1
    }
    
    var scrollViewContentOffset: CGFloat {
        return scrollView!.contentOffset.x + scrollViewXInset
    }
    
    var selectedDuration: TimeInterval {
        return Double(indexForCorrectedOffset(offset: scrollViewContentOffset)) * 30.0
    }
}

extension Comparable {
    func clamp(lower: Self, upper: Self) -> Self {
        return min(max(self, lower), upper)
    }
}

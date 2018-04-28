//
//  TimerButtonView.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit

enum TimerState {
    case stopped
    case running
}

protocol TimerButtonViewDelegate {
    func startButtonTapped()
    func pauseButtonTapped()
    func resetButtonTapped()
    func stopButtonTapped()
}

@IBDesignable class TimerButtonView: XibView {
    
    @IBOutlet var stoppedButtonView: UIView!
    @IBOutlet var runningButtonView: UIView!
    
    var delegate: TimerButtonViewDelegate?
    
    func set(state: TimerState) {
        stoppedButtonView.isHidden = state != .stopped
        runningButtonView.isHidden = state != .running
    }
    
    @IBAction func startButtonTapped() { delegate?.startButtonTapped() }
    
    @IBAction func pauseButtonTapped() { delegate?.pauseButtonTapped() }
    
    @IBAction func resetButtonTapped() { delegate?.resetButtonTapped() }
    
    @IBAction func stopButtonTapped() { delegate?.stopButtonTapped() }
}

@IBDesignable
class XibView : UIView {
    
    var contentView:UIView?
    @IBInspectable var nibName:String?
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
}

//
//  LightTimerViewController.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 27/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit
import HomeKit
class LightTimerSetupViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeSelector: UIDatePicker!
    @IBOutlet var startTimerButton: UIButton!
    
    var service: HMService? {
        didSet {
            guard let service = service else { return }
            populateView(withService: service)
        }
    }
    
    init(service: HMService) {
        defer {
            self.service = service
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func populateView(withService service: HMService) {
        loadViewIfNeeded()
        
        titleLabel.text = service.displayTitle(separatedBy: "\n")
        timeSelector.countDownDuration = 60
    }
    
    @IBAction func startTimerButtonTapped() {
        let timerDurationSeconds = Int(timeSelector.countDownDuration)
        
        guard let powerCharacteristic = self.service?.characteristics.first(where: { $0.characteristicType == HMCharacteristicTypePowerState }) else { return }
        
        let powerSetting = false
        
        let timerEndAction: (UIViewController) -> (() -> Void) = { viewController in
            return {
                powerCharacteristic.writeValue(powerSetting, completionHandler: { error in
                    if error != nil {
                        let alert = UIAlertController(title: "Error writing value", message: error.debugDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        viewController.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }
        
        let timerViewController: TimerViewController = UIStoryboard(name: "Timer", bundle: nil).instantiateInitialViewController() as! TimerViewController
        
        let timerModel = TimerModel(duration: timerDurationSeconds, completionHandler: timerEndAction(timerViewController))
        timerViewController.timerModel = timerModel
        self.navigationController?.pushViewController(timerViewController, animated: true)
    }
}

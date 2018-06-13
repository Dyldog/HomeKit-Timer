//
//  HomeTimer.swift
//  HomeTimer v2
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import Foundation
import HomeKit

typealias PowerCharacteristicSetting = (HMCharacteristic, Bool)

protocol HomeTimerDelegate {
    func timerDidTick(_ timer: HomeTimer)
    func timerDidComplete(_ timer: HomeTimer)
    func timer(_ timer: HomeTimer, didError error: Error, whileRunningSetting: PowerCharacteristicSetting)
}

class HomeTimer {
    let duration: Int
    var timeRemaining: Int
    let settings: [PowerCharacteristicSetting]
    
    var timer: Timer?
    
    var delegate: HomeTimerDelegate?
    
    init(duration: Int, settings: [PowerCharacteristicSetting]) {
        self.duration = duration
        self.timeRemaining = duration
        self.settings = settings
    }
    
    func start() {
        guard timer == nil else { fatalError("Tried to start already running timer") }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func stop() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    @objc private func tick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        }
        
        delegate?.timerDidTick(self)
        
        if timeRemaining <= 0 {
            complete()
        }
    }
    
    private func complete() {
        timer?.invalidate()
        self.timer = nil
        
        runSettings()
        delegate?.timerDidComplete(self)
    }
    
    private func runSettings() {
        settings.forEach { (characteristic, setting) in
            characteristic.writeValue(setting, completionHandler: { error in
                if let error = error { self.handleError(error, forSetting: (characteristic, setting)) }
            })
        }
    }
    
    private func handleError(_ error: Error, forSetting setting: PowerCharacteristicSetting) {
        delegate?.timer(self, didError: error, whileRunningSetting: setting)
    }
}

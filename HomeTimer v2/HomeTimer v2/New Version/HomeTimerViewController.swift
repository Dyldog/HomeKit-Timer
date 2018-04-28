//
//  HomeTimerViewController.swift
//  HomeTimer v2
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit
import HomeKit

class HomeTimerViewController: UIViewController, HMHomeManagerDelegate, TimerButtonViewDelegate, HomeServiceSelectorViewDelegate, HomeTimerDelegate {
    
    @IBOutlet var timeView: EggTimeView!
    
    @IBOutlet var serviceView: HomeServiceSelectorView! {
        didSet {
            serviceView.delegate = self
        }
    }
    
    @IBOutlet var buttonView: TimerButtonView! {
        didSet {
            buttonView.delegate = self
        }
    }
    
    var timer: HomeTimer?
    
    var manager: HMHomeManager?
    
    let knownServiceTypes = [
        HMServiceTypeLightbulb,
        HMServiceTypeFan,
        HMServiceTypeOutlet
    ]
    
    var characteristics = [HMCharacteristic]()
    
    // MARK: - View
    
    override func viewDidLoad() {
        manager = HMHomeManager()
        manager?.delegate = self
    }
    
    func set(viewState: TimerState) {
        timeView.set(interactionEnabled: viewState == .stopped)
        serviceView.set(selectionEnabled: viewState == .stopped)
        buttonView.set(state: viewState)
    }
    
    // MARK: - Timer
    
    private func startTimer() {
        let selectedCharacteristics = zip(characteristics, serviceView.cellItems).filter { $0.1.status != .unselected }
        
        let characteristicSettings = selectedCharacteristics.map { (characteristic, cellItem) in
            return (characteristic, cellItem.status.asBool!)
        }
        
        timer = HomeTimer(duration: Int(timeView.selectedDuration), settings: characteristicSettings)
        timer?.delegate = self
        
        set(viewState: .running)
        
        timer!.start()
    }
    
    func pauseTimer() {
        guard let timer = timer else { fatalError("Timer pause requested when no timer running") }
        timer.stop()
        
        set(viewState: .paused)
    }
    
    func resumeTimer() {
        guard let timer = timer else { fatalError("Timer resume requested when no timer running") }
        
        set(viewState: .running)
        timer.start()
    }
    
    func resetTimer() {
        guard let timer = timer else { fatalError("Timer reset requested when no timer running") }
        
        self.timeView.setDuration(duration: TimeInterval(timer.duration))
        stopTimer()
        startTimer()
    }
    
    func stopTimer() {
        guard let timer = timer else { fatalError("Timer stop requested when no timer running") }
        
        self.timeView.setDuration(duration: TimeInterval(timer.duration))
        set(viewState: .stopped)
        timer.stop()
    }
    
    // MARK: - Conformance
    
    // MARK: HMHomeManagerDelegate
    
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        let home = manager.homes[0]
        
        let allServices = home.accessories.flatMap({ $0.services })
        
        let knownServices = allServices.filter { service in knownServiceTypes.contains(service.serviceType) }

        characteristics = knownServices.flatMap{ service in
            service.characteristics.first(where: { $0.characteristicType == HMCharacteristicTypePowerState })
        }
        
        serviceView.cellItems = characteristics.map { characteristic in
            return ServiceCellItem(title: characteristic.service!.displayTitle)
        }
        
        serviceView.reloadData()
    }
    
    // MARK: HomeServiceSelectorViewDelegate
    
    func homeServiceSelectorView(_ serviceSelectorView: HomeServiceSelectorView, didSelectServiceAt index: Int) {
        let cellItem = serviceSelectorView.cellItems[index]
        let characteristic = characteristics[index]
        guard let characteristicValue = characteristic.value as? Bool else { return }
        
        
        let newStatus: ServiceSelection = {
            switch cellItem.status {
            case .unselected: return !characteristicValue ? .on : .off
            case .off: return .on
            case .on: return .off
            }
        }()
        
        serviceSelectorView.cellItems[index] = ServiceCellItem(
            title: cellItem.title,
            status: newStatus
        )
        
        serviceSelectorView.reloadItems(at: [index])
    }
    
    // MARK: TimerButtonViewDelegate
    
    func startButtonTapped() {
        startTimer()
    }
    
    func pauseButtonTapped() {
        pauseTimer()
    }
    
    func resumeButtonTapped() {
        resumeTimer()
    }
    
    func resetButtonTapped() {
        let alert = UIAlertController(title: "Reset?", message: "Are you sure you want to reset the timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.resetTimer()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func stopButtonTapped() {
        let alert = UIAlertController(title: "Reset?", message: "Are you sure you want to reset the timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.stopTimer()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: HomeTimerDelegate
    
    func timerDidTick(_ timer: HomeTimer) {
        timeView.setDuration(duration: TimeInterval(timer.timeRemaining))
    }
    
    func timerDidComplete(_ timer: HomeTimer) {
        timeView.setDuration(duration: TimeInterval(timer.duration))
        set(viewState: .stopped)
    }
    
    func timer(_ timer: HomeTimer, didError error: Error, whileRunningSetting: PowerCharacteristicSetting) {
        let alert = UIAlertController(title: "Error setting value", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

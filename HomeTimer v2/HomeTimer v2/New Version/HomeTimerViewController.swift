//
//  HomeTimerViewController.swift
//  HomeTimer v2
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit
import HomeKit

class HomeTimerViewController: UIViewController, HMHomeManagerDelegate, TimerButtonViewDelegate, HomeServiceSelectorViewDelegate {
    
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
    
    var manager: HMHomeManager?
    
    let knownServiceTypes = [
        HMServiceTypeLightbulb,
        HMServiceTypeFan,
        HMServiceTypeOutlet
    ]
    
    var characteristics = [HMCharacteristic]()
    
    override func viewDidLoad() {
        manager = HMHomeManager()
        manager?.delegate = self
    }
    
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
    
    // MARK: - HomeServiceSelectorViewDelegate
    
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
    
    // MARK: - TimerButtonViewDelegate
    
    func startButtonTapped() {
        // START TIMER
        print(timeView.selectedDuration)
        
        let selectedCharacteristics = zip(characteristics, serviceView.cellItems).filter { $0.1.status != .unselected }
        print(selectedCharacteristics.map { ($0.0.service?.displayTitle, $0.1.status.asBool) })
        
        let completionUnits = selectedCharacteristics.map { (characteristic, cellItem) in
            return {
                characteristic.writeValue(
                    cellItem.status.asBool!,
                    completionHandler: { error in /* TODO */ }
                )
            }
        }
        
        let timerCompletion = {
            completionUnits.forEach { $0() }
        }
        
    }
    
    func pauseButtonTapped() {
        // PAUSE TIMER
    }
    
    func resetButtonTapped() {
        // CONFIRMATION ALERT
        // RESET TIMER
    }
    
    func stopButtonTapped() {
        // CONFIRMATION ALERT
        // STOP TIMER
    }
}

//
//  HomeTimerViewController.swift
//  HomeTimer v2
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit
import HomeKit

class HomeTimerViewController: UIViewController, HMHomeManagerDelegate, TimerButtonViewDelegate {
    
    @IBOutlet var timeView: EggTimeView!
    @IBOutlet var serviceView: HomeServiceSelectorView!
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
    
    var services = [HMService]()
    
    override func viewDidLoad() {
        manager = HMHomeManager()
        manager?.delegate = self
    }
    
    override func prepareForInterfaceBuilder() {
        serviceView.cellItems = [
            .init(title: "One", status: .unselected),
            .init(title: "Two", status: .off),
            .init(title: "Three", status: .on),
            .init(title: "Four"),
            .init(title: "Five"),
        ]
        
        serviceView.reloadData()
    }
    
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        let home = manager.homes[0]
        
        let allServices = home.accessories.flatMap({ $0.services })
        
        services = allServices.filter { service in knownServiceTypes.contains(service.serviceType) }

        serviceView.cellItems = services.map { service in
            return ServiceCellItem(title: service.displayTitle)
        }
        
        serviceView.reloadData()
    }
    
    // MARK: - TimerButtonViewDelegate
    
    func startButtonTapped() {
        // START TIMER
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

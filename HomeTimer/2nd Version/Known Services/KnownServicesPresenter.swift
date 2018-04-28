//
//  KnownServicesPresenter.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit
import HomeKit

protocol KnownServicesDisplay {
    func reloadTableView()
}

class KnownServicesPresenter: SimpleListPresenter<HMService>, HMHomeManagerDelegate {
    
    var display: KnownServicesDisplay?
    
    let manager: HMHomeManager
    
    var chosenHome: HMHome? {
        let homes = manager.homes
        guard homes.count > 0 else { return nil }
        return homes[0]
    }
    
    let knownServiceTypes = [
        HMServiceTypeLightbulb,
        HMServiceTypeFan,
        HMServiceTypeOutlet
    ]
    
    var knownServices = [HMService]()
    
    var navigationController: UINavigationController
    var initialViewController: KnownServicesViewController
    
    override init() {
        navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        initialViewController = navigationController.viewControllers[0] as! KnownServicesViewController
        
        manager = HMHomeManager()
        
        super.init()
        
        initialViewController.presenter = self
        manager.delegate = self
    }
    
    // MARK: HMHomeManagerDelegate
    
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        let home = manager.homes[0]
        
        let services = home.accessories.flatMap({ $0.services })
        
        knownServices = services.filter { service in knownServiceTypes.contains(service.serviceType) }
        
        initialViewController.modelItems = knownServices
        initialViewController.reloadData()
    }
    
    override func modelItemSelected(_ service: HMService) {
        let viewController: LightTimerSetupViewController = UIStoryboard(name: "TimerSetup", bundle: nil).instantiateInitialViewController() as! LightTimerSetupViewController
        viewController.service = service
        navigationController.pushViewController(viewController, animated: true)
    }
}

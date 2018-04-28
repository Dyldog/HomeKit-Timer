//
//  KnownServicesViewController.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 27/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import HomeKit

class KnownServicesViewController: SimpleListViewController<HMService> {
    
    override func initialize() {
        cellInitializer = { service, cell in
            guard let room = service.accessory?.room else { return }
            cell.textLabel?.text = "\(room.name) \(service.name)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

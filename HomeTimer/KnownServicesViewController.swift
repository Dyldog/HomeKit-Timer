//
//  KnownServicesViewController.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 27/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit
import HomeKit

class KnownServicesViewController: UITableViewController, HMHomeManagerDelegate {
    
    var manager: HMHomeManager?
    
    var chosenHome: HMHome? {
        guard let homes = manager?.homes,
            homes.count > 0 else { return nil }
        return homes[0]
    }
    
    let knownServiceTypes = [
        HMServiceTypeLightbulb,
        HMServiceTypeFan,
        HMServiceTypeOutlet
    ]
    
    var knownServices = [HMService]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = HMHomeManager()
        manager?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        let home = manager.homes[0]
        
        let services: [HMService] = home.accessories.reduce([], { array, accessory in
            var array = array
            array.append(contentsOf: accessory.services)
            return array
        })
        
        knownServices = services.filter { service in knownServiceTypes.contains(service.serviceType) }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return knownServices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.numberOfLines = 0
        
        let service = knownServices[indexPath.row]
        
        cell.textLabel?.text = service.displayTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = knownServices[indexPath.row]
        
        let viewController: LightTimerSetupViewController = UIStoryboard(name: "TimerSetup", bundle: nil).instantiateInitialViewController() as! LightTimerSetupViewController
        viewController.service = service
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HMService {
    var displayTitle: String {
        return displayTitle()
    }
    
    func displayTitle(separatedBy separator: String = "/") -> String {
        var titleComponents = [String]()
        
        if let accessory = self.accessory {
            if let room = accessory.room {
                titleComponents.append(room.name)
            }
            
            // titleComponents.append(accessory.name)
        }
        
        titleComponents.append(self.name)
        
        return titleComponents.joined(separator: separator)
    }
}

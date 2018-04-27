//
//  ViewController.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 26/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit
import HomeKit

class ViewController: UITableViewController, HMHomeManagerDelegate {
    
    var manager: HMHomeManager?
    
    var chosenHome: HMHome? {
        guard let homes = manager?.homes,
                homes.count > 0 else { return nil }
        return homes[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = HMHomeManager()
        manager?.delegate = self
    }

    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenHome?.accessories.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        let accessory = chosenHome!.accessories[indexPath.row]
        cell.textLabel?.text = accessory.name
        cell.detailTextLabel?.text = accessory.room?.name
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accessory = chosenHome!.accessories[indexPath.row]
        let servicesViewController = ServicesViewController(accessory: accessory)
        self.navigationController?.pushViewController(servicesViewController, animated: true)
    }

}


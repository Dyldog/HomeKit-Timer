//
//  HomeKit+Extensions.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import HomeKit

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

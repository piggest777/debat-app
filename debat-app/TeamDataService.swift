//
//  TeamDataService.swift
//  debat-app
//
//  Created by Denis Rakitin on 2018-09-14.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import Foundation


class TeamDataService {
    
   static let instance = TeamDataService()
    
    var teamArray = [TeamSetings]()
    
    func getTeamArray(handler: @escaping (Bool)->()) {
        DataService.instance.getTeamsArray { (returnedTeamArray) in
            self.teamArray = returnedTeamArray
            handler(true)
        }
    }
    
}

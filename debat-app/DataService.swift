//
//  DataService.swift
//  debat-app
//
//  Created by Denis Rakitin on 2018-08-25.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_TEAMS = DB_BASE.child("teams")
    
    var REF_USERS:DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_TEAMS
    }
    
    
    func createUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getUserEmails(handler: @escaping (_ EmailArray: [String])->()) {
        
        var emailArray = [String]()
        
        REF_USERS.observeSingleEvent(of: .value) { (userDataSnapshot) in
            guard let userDataSnapshot = userDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userDataSnapshot {
                
               let email =  user.childSnapshot(forPath: "email").value as! String
                emailArray.append(email)
            }
            handler(emailArray)
        }
        
    }
    
}

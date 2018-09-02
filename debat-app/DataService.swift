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
    
    var teamArray = [String]()
    
    
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_TEAMS = DB_BASE.child("teams")
    
    var REF_USERS:DatabaseReference {
        return _REF_USERS
    }
    
    var REF_TEAMS: DatabaseReference {
        return _REF_TEAMS
    }
    
    
    func createUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func createTeam(team: TeamSetings, completionHandler: @escaping (Bool)->()){
        
        let name = team.name
        let score = team.totalScore
        let teamSettings = ["teamName": name, "teamScore": score] 
        
        REF_TEAMS.childByAutoId().updateChildValues(teamSettings)
        
        getTeamsName() { (returnedTeamArray) in
            self.teamArray = returnedTeamArray
            
            if self.teamArray.contains(name){
                print ("Команда добавлена в базу")
                completionHandler(true)
                self.teamArray = []
            } else {
                print("Команда не была добавлена в базу")
                completionHandler (false)
                self.teamArray = []
            }
        }
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
    
    func getTeamsName(handler: @escaping (_ teamArray: [String])->()){
        var teamArray = [String]()
        
        REF_TEAMS.observeSingleEvent(of: .value) { (teamDataSnapshot) in
            guard let teamDataSnapshot = teamDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for team in teamDataSnapshot {
                
                
                let name = team.childSnapshot(forPath: "teamName").value as! String
                teamArray.append(name)
            }
            
            handler(teamArray)
        }
    }
    
    func checkIsTeamAlreadyInLst (teamname name: String, handler: @escaping (Bool)->()){
        var teamNameArray = [String]()
        REF_TEAMS.observeSingleEvent(of: .value) { (teamsDataSnapshot) in
            guard let teamsDataSnapshot = teamsDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for team in teamsDataSnapshot {
                let currientTeamNameInBase  = team.childSnapshot(forPath: "teamName").value as! String
                
                teamNameArray.append(currientTeamNameInBase)
            }
            print(teamNameArray)
            
            if teamNameArray.contains(name) {
                handler(true)
            } else {
                handler(false)
            }
        }
        
    }
    
    func getTeamsArray(completionHandler: @escaping (_ teamToReturnArray: [TeamSetings])->()) {
        
        var teamsArray = [TeamSetings]()
        
        REF_TEAMS.observeSingleEvent(of: .value) { (teamsDataSnapshot) in
            guard let teamsDataSnapshot = teamsDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for team in teamsDataSnapshot {
                
                let teamName = team.childSnapshot(forPath: "teamName").value as! String
                let teamScore = team.childSnapshot(forPath: "teamScore").value as! String
                
                let teamToAdd = TeamSetings(name: teamName, totalScore: teamScore)
                teamsArray.append(teamToAdd)
            }
            
            completionHandler(teamsArray)
        }
    }
    
    func getTeamAutoId(forTeam teamForIndentificate: TeamSetings, completionHandler: @escaping (_ teamId: String)->()){
        
        var teamKey = String()
        REF_TEAMS.observeSingleEvent(of: .value) { (teamsDataSnapshot) in
            guard let teamDataSnapshot = teamsDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for team in teamDataSnapshot {
                
                let teamName = team.childSnapshot(forPath: "teamName").value as! String
                
                if teamForIndentificate.name == teamName {
                     teamKey = team.key
                }
                
            }
            print("ключ команды : \(teamKey)")
            completionHandler(teamKey)
        }
    }
    
    func removeTeamFromFirebase(forId id: String, completionHandler: @escaping (Bool)->()){
        REF_TEAMS.child(id).removeValue { (error, reference) in
            if error != nil {
                
                print("что то пошло не так")
                completionHandler(false)
            } else {
                completionHandler(true)
                print("все ок")
            }
        }
    }
    
}

//
//  Round1VC.swift
//  debat-app
//
//  Created by Denis Rakitin on 17/06/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit
import Firebase

class Round1VC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var teamArray = [TeamSetings]()
    var spinner: UIActivityIndicatorView?
    var screenSize = UIScreen.main.bounds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addSpinner()
        TeamDataService.instance.getTeamArray { (success) in
            if success {
                self.teamArray = TeamDataService.instance.teamArray
                print("cписок комманд получен")
                self.initRoundScore1(handler: { (success) in
                    if success {
                        self.tableView.reloadData()
                        self.removeSpinner()
                    }
                })
            }
            
        }
   
//        DataService.instance.getTeamsArray { (returnenedTeamsArray) in
//            TeamDataService.instance.teamArray = returnenedTeamsArray
//            self.initRoundScore1()
//            self.tableView.reloadData()
//            self.removeSpinner()
//        }
    }
    
    
    func initRoundScore1 (handler: @escaping (Bool)->()){
        DataService.instance.REF_TEAMS.observeSingleEvent(of: .value) { (teamsDataSnapshot) in
            guard let teamsDataSnapshot = teamsDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for team in teamsDataSnapshot {
                
                let key = team.key
                let teamName = team.childSnapshot(forPath: "teamName").value as! String
                if team.hasChild("1RoundScore") {
                    print("очки команды \(teamName) инициализированы")
                } else {
                    let startScore: [String: Double] = ["1Task": 0.0, "2Task": 0.0, "3Task": 0.0, "4Task": 0.0 ]
                    let firstRoundInitRef = DataService.instance.REF_TEAMS.child(key).child("1RoundScore")
                    firstRoundInitRef.setValue(startScore)
                    firstRoundInitRef.updateChildValues(["doneIndicator": false])
                }
            }
            handler(true)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") as? TeamResultCell else {return UITableViewCell()}

        let team = teamArray[indexPath.row]

        cell.teamName.text = team.name
        cell.teamFinalScore.text = String(team.totalScore)
        
        DataService.instance.getTeamsRoundScore(forTeam: team, round: 1) { (returnedRoundScores) in
            let roundScrores = returnedRoundScores
            
            cell.konkurs1Result.text = String(roundScrores.task1)
            cell.konkurs2Result.text = String(roundScrores.task2)
            cell.konkurs3Result.text = String(roundScrores.task3)
            cell.konkurs4Result.text = String(roundScrores.task4)
            
            if roundScrores.doneIdicator == false {
                cell.doneIndicator.layer.backgroundColor = #colorLiteral(red: 0.9568563104, green: 0.2473894358, blue: 0.1092854217, alpha: 1)
            } else {
                cell.doneIndicator.layer.backgroundColor = #colorLiteral(red: 0, green: 0.7844975591, blue: 0.3059647083, alpha: 1)
            }
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       guard let teamRoundScoreEditorVC = storyboard?.instantiateViewController(withIdentifier: "RoundTeamScoreEditor") as? AddTeamRoundScoreVC else {return}
        let team = teamArray[indexPath.row]
        DataService.instance.getTeamsRoundScore(forTeam: team, round: 1) { (returnedRoundScores) in
            let roundScrores = returnedRoundScores
            teamRoundScoreEditorVC.initTeamRoundScore(team: team, roundedScores: roundScrores, round: 1)
        }
        
        present(teamRoundScoreEditorVC, animated: true, completion: nil)
    }

    func addSpinner () {
        spinner = UIActivityIndicatorView()
        spinner?.center = CGPoint(x: (screenSize.width/2) - ((spinner?.frame.width)!/2), y: 150)
        spinner?.activityIndicatorViewStyle = .whiteLarge
        spinner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spinner?.startAnimating()
        tableView?.addSubview(spinner!)
    }
    
    func removeSpinner() {
        
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }


}

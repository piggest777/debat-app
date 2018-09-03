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
        DataService.instance.getTeamsArray { (returnenedTeamsArray) in
            self.teamArray = returnenedTeamsArray
            self.initRoundScore1()
            self.tableView.reloadData()
            self.removeSpinner()
        }
    }
    
    func initRoundScore1 (){
        DataService.instance.REF_TEAMS.observeSingleEvent(of: .value) { (teamsDataSnapshot) in
            guard let teamsDataSnapshot = teamsDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for team in teamsDataSnapshot {
                
                let key = team.key
                let teamName = team.childSnapshot(forPath: "teamName").value as! String
                if team.hasChild("1RoundScore") {
                    print("очки команды \(teamName) инициализированы")
                } else {
                    let startScore: [String: Int] = ["1Round-1Konkurs": 0, "1Round-2Konkurs": 0, "1Round-3Konkurs": 0, "1Round-4Konkurs": 0 ]
                    DataService.instance.REF_TEAMS.child(key).child("1RoundScore").updateChildValues(startScore)
                }
            }
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
        cell.teamFinalScore.text = team.totalScore
        
        DataService.instance.getTeamsRoundScore(forTeam: team, round: 1) { (returnedRoundScores) in
            let roundScrores = returnedRoundScores
            
            cell.konkurs1Result.text = String(roundScrores.task1)
            cell.konkurs2Result.text = String(roundScrores.task2)
            cell.konkurs3Result.text = String(roundScrores.task3)
            cell.konkurs4Result.text = String(roundScrores.task4)
        }

        return cell
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

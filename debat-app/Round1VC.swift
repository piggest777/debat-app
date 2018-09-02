//
//  Round1VC.swift
//  debat-app
//
//  Created by Denis Rakitin on 17/06/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit

class Round1VC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        guard let setUpTeamVC = storyboard?.instantiateViewController(withIdentifier: "SetUpTeamVC") as? SetUpTeamVC else {return}
//        setUpTeamVC.fetch()
//        tableView.reloadData()
//
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return SetUpTeamVC.teams.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") as? TeamResultCell else {return UITableViewCell()}
//
//        let team = SetUpTeamVC.teams[indexPath.row]
//
//        cell.teamName.text = team.name
//        cell.teamFinalScore.text = String(describing: team.finalScore)
//
//
//
//        return cell
//    }

    


}

//
//  SetUpTeamVC.swift
//  debat-app
//
//  Created by Denis Rakitin on 11/06/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit
import CoreData

class SetUpTeamVC: UIViewController {

    //Outlets
    
    @IBOutlet weak var teamName: UITextField!
    
    @IBOutlet weak var teamScore: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    //var
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var teams: [Team] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        fetch()
        tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
        tableView.reloadData()
        
    }
    

    @IBAction func backButtonWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

    @IBAction func addTeamBtnWasPressed(_ sender: Any) {
        if teamName.text != "", teamScore.text != "" {
            self.save(completon: { (success) in
                fetch()
                tableView.reloadData()
            })
        }
        
    }


}

extension SetUpTeamVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
         print("number of teams is \(teams.count)")
        
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SetUpCell") as? TeamSetUpCell else {return UITableViewCell()}
        
        let team = teams[indexPath.row]
        print("now team is \(teams[indexPath.row])")
        
        
        cell.configureCell(team: team)
        
        return cell
    }
    
}

extension SetUpTeamVC {
    
    
    func save (completon: (_ finished: Bool) -> ()){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let team = Team(context: managedContext)
        
        team.name = teamName.text
        team.finalScore = Double(teamScore.text!)!
        
        
        
        do {
            try managedContext.save()
            print("Успешно сохранено")
            completon(true)
        } catch {
            debugPrint("Невозможно сохранить команду из за ошибки \(error.localizedDescription)")
            completon(false)
        }
        
    }
    
    
    func fetch () {
        guard let managedComtext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Team>(entityName: "Team")
        
        do {
            teams = try managedComtext.fetch(fetchRequest)
        } catch {
            debugPrint("Ошибка при наполнении: \(error.localizedDescription)")
        }
        
        
        
    }
}

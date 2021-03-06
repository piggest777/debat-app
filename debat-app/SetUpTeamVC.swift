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
    
    static public var teams: [Team] = []
    
    
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
                teamName.text = ""
                teamScore.text = ""
            })
        }
        
    }
    
    
    @IBAction func deleteAllTeamsBtnWasPressed(_ sender: Any) {
    
        for team in SetUpTeamVC.teams {
            deleteTeams(team: team)
        }
        
        SetUpTeamVC.teams = []
        tableView.reloadData()
    
    }
}

extension SetUpTeamVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SetUpTeamVC.teams.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SetUpCell") as? TeamSetUpCell else {return UITableViewCell()}
        
        let team = SetUpTeamVC.teams[indexPath.row]
        
        let teamName: String = team.name!
        
        setProgress(name: teamName)

        
        cell.configureCell(team: team)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
 //   func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
 //       return UITableViewCellEditingStyle.delete
  //  }
    

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let delete = UITableViewRowAction(style: .destructive, title: "УДАЛИТЬ") { (rowAtAction, indexPath) in
            
            self.deleteTeam(atIndexPath: indexPath)
            self.fetch()

            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
               
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return [delete]
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            deleteTeam(atIndexPath: indexPath)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
}

extension SetUpTeamVC {
    
    
    func save (completon: (_ finished: Bool) -> ()){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let team = Team(context: managedContext)
        
        team.name = teamName.text
        team.finalScore = Double(teamScore.text!)!
        
        let scoresFirstRound = Scores(context: managedContext)
        scoresFirstRound.konkurs1 = 0
        scoresFirstRound.konkurs2 = 0
        scoresFirstRound.konkurs3 = 0
        scoresFirstRound.konkurs4 = 0
        scoresFirstRound.numberOfRound = 1
        
        let scoresSecondRound = Scores(context: managedContext)
        scoresSecondRound.konkurs1 = 0
        scoresSecondRound.konkurs2 = 0
        scoresSecondRound.konkurs3 = 0
        scoresSecondRound.konkurs4 = 0
        scoresSecondRound.numberOfRound = 2
        
        let scoresThirdRound = Scores(context: managedContext)
        scoresThirdRound.konkurs1 = 0
        scoresThirdRound.konkurs2 = 0
        scoresThirdRound.konkurs3 = 0
        scoresThirdRound.konkurs4 = 0
        scoresThirdRound.numberOfRound = 3
        
        let scoresFourthRound = Scores(context: managedContext)
        scoresFourthRound.konkurs1 = 0
        scoresFourthRound.konkurs2 = 0
        scoresFourthRound.konkurs3 = 0
        scoresFourthRound.konkurs4 = 0
        scoresFourthRound.numberOfRound = 4
        
        team.addToScores(scoresFirstRound)
        team.addToScores(scoresSecondRound)
        team.addToScores(scoresThirdRound)
        team.addToScores(scoresFourthRound)
        

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
            SetUpTeamVC.teams = try managedComtext.fetch(fetchRequest)
        } catch {
            debugPrint("Ошибка при наполнении: \(error.localizedDescription)")
        }
        
        
        
    }
    
    func deleteTeam (atIndexPath indexPath: IndexPath) {
        let managedContex = appDelegate?.persistentContainer.viewContext
        
        managedContex?.delete(SetUpTeamVC.teams[indexPath.row])
        
        do {
            try managedContex?.save()
            print("Команда успешно удалена!")
                    } catch {
            debugPrint("Невозможно удалить команду по причине: \(error.localizedDescription)")
            
        }
    }
    
    func deleteTeams (team: Team) {
        let managedContex = appDelegate?.persistentContainer.viewContext
        
        managedContex?.delete(team)
        
        do {
            try managedContex?.save()
            print("Команда успешно удалена!")
        } catch {
            debugPrint("Невозможно удалить команду по причине: \(error.localizedDescription)")
            
        }
    }
    
    func setProgress(name: String) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        var scores = [Scores]()
 //       let teamforScores = teams[indexPath.row].value(forKey: "name")
//        value(forKey	: "konkurs1")
        
        let fetchRequest = NSFetchRequest<Scores>(entityName: "Scores")
        fetchRequest.predicate = NSPredicate(format: "team.name == %@", name)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "numberOfRound", ascending: true)]
        
        do{
         scores = try managedContext.fetch(fetchRequest)
            
            let firstScore = scores.first
            let lastScore = scores.last
            let secondScore = scores[1]
            
            print("score for first chalange is \(String(describing: firstScore!.konkurs1)) and last challenge is \(String(describing: lastScore!.konkurs1)) and second chellange is \(String(describing: secondScore.konkurs1))")
       //     print(scores)
        } catch {
            debugPrint(error)
        }

//        let teamName = teams[indexPath.row].value(forKey: "name")
        
//        let konkurs1Scrores = (changeTeamScrore as AnyObject).value(forKey: "konkurs1")
        
        
//        print("value \(String(describing: teamName)) for konkurs 1 = \(String(describing: changeTeamScrore))")
        
//        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
//            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
//        } else {
//            return
//        }
        do {
            try managedContext.save()
            print("Successfuly set progress")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
}

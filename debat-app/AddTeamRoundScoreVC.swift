//
//  AddTeamRoundScoreVC.swift
//  debat-app
//
//  Created by Denis Rakitin on 2018-09-12.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit

class AddTeamRoundScoreVC: UIViewController {
    
    @IBOutlet weak var opppositeTeam1: UILabel!
    
    @IBOutlet weak var oppositeTeam2: UILabel!
    
    @IBOutlet weak var task1Score: UILabel!
    
    @IBOutlet weak var task2Score: UILabel!
    
    @IBOutlet weak var task3Score: UILabel!
    
    @IBOutlet weak var task4Score: UILabel!
    
    @IBOutlet weak var addScorewindow: UITextField!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var task1Button: UIButton!
    
    @IBOutlet weak var task2Button: UIButton!
    
    @IBOutlet weak var task3Button: UIButton!
    
    @IBOutlet weak var task4Button: UIButton!
    
    @IBOutlet weak var teamNotFinishRound: UIButton!
    
    @IBOutlet weak var teamFinishRound: UIButton!
    
    var taskChoose: NumberOfTask = .firstTask
    var teamKey: String?
    var numberOfRound: Int?
    var doneIndicatorStatus: Bool?
    var team: TeamSetings?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        task1Button.buttonWasSelected()
        task2Button.buttonWasDeselected()
        task3Button.buttonWasDeselected()
        task4Button.buttonWasDeselected()
        self.hideKeyboardWhenTappedAround()
        
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    func initTeamRoundScore (team: TeamSetings, roundedScores: RoundScores, round: Int){
        teamName.text  = "\(team.name): Раунд \(round)\n \(team.totalScore)"
        task1Score.text = "Задание № 1: \n \(roundedScores.task1) "
        task2Score.text = "Задание № 2: \n \(roundedScores.task2)"
        task3Score.text = "Задание № 3: \n \(roundedScores.task3)"
        task4Score.text = "Задание № 4: \n \(roundedScores.task4)"
        doneIndicatorStatus = roundedScores.doneIdicator
        print(doneIndicatorStatus)
        if doneIndicatorStatus == false {
            teamNotFinishRound.endRoundNoButtonSelect()
            teamFinishRound.endRoundYesButtonDeselect()
        } else {
            teamFinishRound.endRoundYesButtonSelect()
            teamNotFinishRound.endRoundNoButtonDeselect()
        }
        
        
        DataService.instance.getTeamAutoId(forTeam: team) { (returnedId) in
            self.teamKey = returnedId
        }
        numberOfRound = round
        self.team = team
        
    }
    

    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addScoreBtnWasPressed(_ sender: Any) {
        if addScorewindow.text != "" {
            if addScorewindow.text!.isStringAnDouble() {
                let task: NumberOfTask = taskChoose
                let score = Double(addScorewindow.text!)
                DataService.instance.REF_TEAMS.child("\(teamKey!)").child("\(numberOfRound!)RoundScore").child("\(task.rawValue)Task").setValue(score!)
                addScorewindow.text = ""
            } else {
                
                let intAlert = UIAlertController(title: "Ошибка", message: "Очки команды введены не в числовом формате", preferredStyle: .alert)
                
                intAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                
                self.present(intAlert, animated: true, completion: nil)
                
            }
            
        } else {
            let createTeamAlert = UIAlertController(title: "Ошибка", message: "Пожалуйста, введите очки команды за раунд", preferredStyle: .alert)
            
            createTeamAlert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            
            self.present(createTeamAlert, animated: true, completion: nil)
        }
    }

    @IBAction func finishRoundBtnWasPressed(_ sender: Any) {
        DataService.instance.changeDoneIndicator(team: team!, teamKey: teamKey!, numberOfRound: numberOfRound!, doneIndicatorStatus: true) { (sussess) in
            self.teamFinishRound.endRoundYesButtonSelect()
            self.teamNotFinishRound.endRoundNoButtonDeselect()
        }
    }
    
    @IBAction func roundNotFinishBtnWasPressed(_ sender: Any) {
        DataService.instance.changeDoneIndicator(team: team!, teamKey: teamKey!, numberOfRound: numberOfRound!, doneIndicatorStatus: false) { (sussess) in
            self.teamNotFinishRound.endRoundNoButtonSelect()
            self.teamFinishRound.endRoundYesButtonDeselect()
        }
    }
    
    
    @IBAction func task1BtnWasPressed(_ sender: Any) {
        task1Button.buttonWasSelected()
        task2Button.buttonWasDeselected()
        task3Button.buttonWasDeselected()
        task4Button.buttonWasDeselected()
        taskChoose = .firstTask
    }
    
    @IBAction func task2BtnWasPressed(_ sender: Any) {
        task1Button.buttonWasDeselected()
        task2Button.buttonWasSelected()
        task3Button.buttonWasDeselected()
        task4Button.buttonWasDeselected()
        taskChoose = .secondTask
        
    }
    
    @IBAction func task3BtnWasPressed(_ sender: Any) {
        task1Button.buttonWasDeselected()
        task2Button.buttonWasDeselected()
        task3Button.buttonWasSelected()
        task4Button.buttonWasDeselected()
        taskChoose = .thirdTask
    }
    
    @IBAction func task4ButtonWasPressed(_ sender: Any) {
        
        task1Button.buttonWasDeselected()
        task2Button.buttonWasDeselected()
        task3Button.buttonWasDeselected()
        task4Button.buttonWasSelected()
        taskChoose = .fourthTask
    }
}

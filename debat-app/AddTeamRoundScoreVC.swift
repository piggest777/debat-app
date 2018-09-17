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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initTeamRoundScore (team: TeamSetings, roundedScores: RoundScores){
        teamName.text  = team.name
        task1Score.text = "Задание № 1: \n \(roundedScores.task1) "
        task2Score.text = "Задание № 2: \n \(roundedScores.task2)"
        task3Score.text = "Задание № 3: \n \(roundedScores.task3)"
        task4Score.text = "Задание № 4: \n \(roundedScores.task4)"
    }



  
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addScoreBtnWasPressed(_ sender: Any) {
    }

    @IBAction func finishRoundBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func roundNotFinishBtnWasPressed(_ sender: Any) {
    }
    
    
    @IBAction func task1BtnWasPressed(_ sender: Any) {
        
        print("task 1 btn was pressed")
    }
    
    @IBAction func task2BtnWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func task3BtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func task4ButtonWasPressed(_ sender: Any) {
    }
    
    
    
    
}

//
//  StartDenateVC.swift
//  debat-app
//
//  Created by Denis Rakitin on 11/06/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit

class StartDebateVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func startGameBtnWasPressed(_ sender: Any) {
    }
    
    
    
    @IBAction func setUpTeamBtnWasPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "SetUpTeamVC", sender: nil)
    }
  


}


//
//  TeamResultCell.swift
//  debat-app
//
//  Created by Denis Rakitin on 16/06/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit

class TeamResultCell: UITableViewCell {
    
    //Outlets
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamFinalScore: UILabel!
    
    @IBOutlet weak var doneIndicator: UIView!
    
    @IBOutlet weak var konkurs1Result: UILabel!

    @IBOutlet weak var konkurs2Result: UILabel!
    
    @IBOutlet weak var konkurs3Result: UILabel!
    
    @IBOutlet weak var konkurs4Result: UILabel!
//
//    @IBOutlet weak var opositeTeamN1: UILabel!
//    
//    @IBOutlet weak var opositeTeamN2: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpView()  {
        doneIndicator.layer.borderWidth = 2.0
        doneIndicator.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        doneIndicator.layer.cornerRadius = doneIndicator.frame.size.height/2
        doneIndicator.clipsToBounds = true
        
    }

}

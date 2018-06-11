//
//  TeamSetUpCell.swift
//  debat-app
//
//  Created by Denis Rakitin on 11/06/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit

class TeamSetUpCell: UITableViewCell {

    //Outlets
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamScore: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(team: Team) {
        self.teamName.text = team.name
        self.teamScore.text = String(describing: team.finalScore)
    
    }
    
    

}

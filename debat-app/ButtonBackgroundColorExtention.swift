//
//  ButtonBackgroundColorExtention.swift
//  debat-app
//
//  Created by Denis Rakitin on 2018-09-12.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit

extension UIButton {
    
    func buttonWasSelected () {
        self.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.7294117647, blue: 1, alpha: 1)
    }
    
    func  buttonWasDeselected()  {
        self.backgroundColor = #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1)
    }
    
    func endRoundNoButtonDeselect() {
        self.backgroundColor = #colorLiteral(red: 0.998909533, green: 0.5078145862, blue: 0.4831186533, alpha: 1)
    }

    func  endRoundNoButtonSelect()  {
        self.backgroundColor = #colorLiteral(red: 0.9568563104, green: 0.2473894358, blue: 0.1092854217, alpha: 1)
    }
    
    func endRoundYesButtonDeselect() {
        self.backgroundColor = #colorLiteral(red: 0.6279227138, green: 0.8354427218, blue: 0.616582036, alpha: 1)
    }
    
    func  endRoundYesButtonSelect()  {
        self.backgroundColor = #colorLiteral(red: 0, green: 0.7844975591, blue: 0.3059647083, alpha: 1)
    }
}



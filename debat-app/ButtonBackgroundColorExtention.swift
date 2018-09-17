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
    
    func endRoundNoButtonSelect () {
        self.backgroundColor = #colorLiteral(red: 0.998909533, green: 0.5078145862, blue: 0.4831186533, alpha: 1)
    }

    func  endRoundNoButtonDeselect()  {
        self.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.3098039216, blue: 0.1882352941, alpha: 1)
    }
    
    func endRoundYesButtonSelect () {
        self.backgroundColor = #colorLiteral(red: 0.6279227138, green: 0.8354427218, blue: 0.616582036, alpha: 1)
    }
    
    func  endRoundYesButtonDeselect()  {
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.7725490196, blue: 0.3647058824, alpha: 1)
    }
}



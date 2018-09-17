//
//  SpinnerTime.swift
//  debat-app
//
//  Created by Denis Rakitin on 2018-09-14.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import Foundation


class SpinnerTime {
    
    func addSpinner () {
        spinner = UIActivityIndicatorView()
        spinner?.center = CGPoint(x: (screenSize.width/2) - ((spinner?.frame.width)!/2), y: 150)
        spinner?.activityIndicatorViewStyle = .whiteLarge
        spinner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spinner?.startAnimating()
        tableView?.addSubview(spinner!)
    }
    
    func removeSpinner() {
        
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }

}

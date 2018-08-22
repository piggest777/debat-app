//
//  TabBarController.swift
//  debat-app
//
//  Created by Denis Rakitin on 17/06/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

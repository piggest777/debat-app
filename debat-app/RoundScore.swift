//
//  RoundScore.swift
//  debat-app
//
//  Created by Denis Rakitin on 2018-09-03.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import Foundation

struct RoundScores {
    var task1: Double
    var task2: Double
    var task3: Double
    var task4: Double
    var doneIdicator: Bool
    
    init(task1: Double, task2: Double, task3: Double, task4: Double, doneIndicator: Bool) {
        self.task1 = task1
        self.task2 = task2
        self.task3 = task3
        self.task4 = task4
        self.doneIdicator = doneIndicator
    }
}

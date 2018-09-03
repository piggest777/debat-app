//
//  RoundScore.swift
//  debat-app
//
//  Created by Denis Rakitin on 2018-09-03.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import Foundation

struct RoundScores {
    var task1: Int
    var task2: Int
    var task3: Int
    var task4: Int
    
    init(task1: Int, task2: Int, task3: Int, task4: Int) {
        self.task1 = task1
        self.task2 = task2
        self.task3 = task3
        self.task4 = task4
    }
}

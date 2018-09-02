//
//  StringCheckIsIntExt.swift
//  debat-app
//
//  Created by Denis Rakitin on 2018-09-02.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import Foundation

extension String {
    func isStringAnInt() -> Bool {
        
        if let _ = Int(self) {
            return true
        }
        return false
    }
}

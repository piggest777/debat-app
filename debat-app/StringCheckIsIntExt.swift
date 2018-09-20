//
//  StringCheckIsIntExt.swift
//  debat-app
//
//  Created by Denis Rakitin on 2018-09-02.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import Foundation

extension String {
    func isStringAnDouble() -> Bool {
        
        if let _ = Double(self) {
            return true
        }
        return false
    }
}

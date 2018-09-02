//
//  UIViewExt.swift
//  breakpoint-app
//
//  Created by Denis Rakitin on 2018-07-31.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit



extension UIView {
    
    
    
    func bindToKeyboard () {
     
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

    }
    
    func unbindFromKeyboard(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let beginigFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - beginigFrame.origin.y
        
        
        
        
      
        
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
//            self.frame.origin.y += deltaY
            self.frame.size.height += deltaY

            
        }, completion:
            {
            
            (true) in
        self.layoutIfNeeded()
        }
//            {
//            (sussess) in
//            if sussess {
//                 DataService.instance.constraintHigh = -deltaY
//                print("дельта Y = \(DataService.instance.constraintHigh)")
//
//            }
//        }
        )
    }
    
//    func getConstraint(handler: @escaping (_ constHigh:CGFloat)->()){
//
//    }
}

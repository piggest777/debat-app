//
//  AuthVC.swift
//  debat-app
//
//  Created by Denis Rakitin on 2018-08-25.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class AuthVC: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
var emailArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
        
    }

    @IBAction func fbBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func googleSignInBtnWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
       
        if let error = error {
            print("Ошибка при авторизации: \(error.localizedDescription)")
            return
        }
        
        guard  let authentification = user.authentication else {return}
        
        let credential = GoogleAuthProvider.credential(withIDToken: (authentification.idToken)!, accessToken: (authentification.accessToken)!)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authDataResult, error) in
            if let error = error {
                print("Ошибка при входе в FireBase: \(error.localizedDescription)")
                return
            }
            
            DataService.instance.getUserEmails(handler: { (returnedUserEmails) in
                self.emailArray = returnedUserEmails
                
                if self.emailArray.contains((authDataResult?.user.email)!) {
                    print("Succesfully sign in with Google")
                    self.dismiss(animated: true, completion: nil)
                    
                } else {
                    
                    let uid = authDataResult!.user.uid
                    
                    let userData = ["provider": authDataResult!.user.providerID, "email": authDataResult!.user.email]
                    DataService.instance.createUser(uid: uid, userData: userData)
                    print("succesfully added user in base by GoogleAuth")
                    self.dismiss(animated: true, completion: nil)
                }
            })
            
        }
        
        
        
        
    }
    

}

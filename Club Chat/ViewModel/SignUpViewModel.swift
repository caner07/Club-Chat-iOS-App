//
//  SignUpViewModel.swift
//  Club Chat
//
//  Created by Caner on 30.07.2021.
//

import Foundation
import Firebase

protocol SignUpViewModelDelegate {
    func loading()
    func success()
    func error()
}

class SignUpViewModel{
    
    var delegate:SignUpViewModelDelegate?
    
    func signUp(email:String,password:String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if  error != nil {
                self.delegate?.error()
            }else{
                self.saveUser(userName: email, password: password)
                self.delegate?.success()
            }
        }
    }
    func saveUser(userName:String,password:String){
        let d = UserDefaults.standard
        d.setValue(userName, forKey: "userName")
        d.setValue(password, forKey: "password")
    }
}

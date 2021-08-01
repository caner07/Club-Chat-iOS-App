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
                self.delegate?.success()
            }
        }
    }
}

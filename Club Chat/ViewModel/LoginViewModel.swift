//
//  LoginViewModel.swift
//  Club Chat
//
//  Created by Caner on 30.07.2021.
//

import Foundation
import Firebase
protocol LoginViewModelDelegate {
    func loading()
    func success()
    func error()
}
class LoginViewModel{
    var delegate:LoginViewModelDelegate?
    
    func login(userName:String,password:String){
        delegate?.loading()
        Auth.auth().signIn(withEmail: "caner@caner.çöm", password: "123456") { authDataResult, error in
            if error != nil {
                self.delegate?.error()
            }else{
                self.delegate?.success()
            }
        }
    }
}

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
        Auth.auth().signIn(withEmail: userName, password: password) { authDataResult, error in
            if error != nil {
                self.delegate?.error()
            }else{
                self.saveUser(userName: userName, password: password)
                self.delegate?.success()
            }
        }
    }
    func saveUser(userName:String,password:String){
        let d = UserDefaults.standard
        d.setValue(userName, forKey: "userName")
        d.setValue(password, forKey: "password")
    }
    func checkUser(){
        let d = UserDefaults.standard
        let userName = d.object(forKey: "userName") ?? "noUser"
        let password = d.object(forKey: "password") ?? "noUser"
        if userName as! String != "noUser" && password as! String != "noUser" {
            login(userName: userName as! String, password: password as! String)
        }
        
    }
    
}

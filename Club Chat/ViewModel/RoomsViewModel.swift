//
//  RoomsViewModel.swift
//  Club Chat
//
//  Created by Caner on 30.07.2021.
//

import Foundation
import Firebase

protocol RoomsViewModelDelegate {
    func loading()
    func success()
    func error()
    func segueToTheChat(room:RoomsModel?)
    func wrongPassword()
}

class RoomsViewModel{
    let db = Firestore.firestore()
    var delegate:RoomsViewModelDelegate?
    var rooms:[RoomsModel]?
    var selectedRoom:RoomsModel?
    
    func loadRooms(){
        db.collection("rooms").order(by: "date").addSnapshotListener{ querySnapshot, error in
            if error != nil {
                self.delegate?.error()
            }else{
                self.rooms = []
                for document in querySnapshot!.documents{
                    let data = document.data()
                    let name = data["name"] as? String
                    let password = data["password"] as? String
                    let date = data["date"] as? String
                    self.rooms?.append(RoomsModel(name: name, password: password, date: date))
                }
                self.delegate?.success()
            }
        }
    }
    func addRoom(roomName:String,password:String){
        db.collection("rooms").addDocument(data: ["name":roomName,"password":password,"date":Date().timeIntervalSince1970]) { error in
            if error != nil {
                self.delegate?.error()
            }else{
                print("Oda Eklendi")
            }
        }
    }
    
    
    func checkPassword(password:String,index:Int){
        if rooms?[index].password == password {
            self.delegate?.segueToTheChat(room: rooms?[index])
        }else{
            self.delegate?.wrongPassword()
        }
    }
    func logOut(){
        do {
            try Auth.auth().signOut()
            deleteUser()
        }
        catch { print("Çıkış yapılamadı!") }
            
            
    }
    func deleteUser(){
        let d = UserDefaults.standard
        d.removeObject(forKey: "userName")
        d.removeObject(forKey: "password")
    }
}

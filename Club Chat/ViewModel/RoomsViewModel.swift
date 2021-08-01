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
}

class RoomsViewModel{
    let db = Firestore.firestore()
    var delegate:RoomsViewModelDelegate?
    var rooms:[RoomsModel]?
    
    
    func loadRooms(){
        db.collection("rooms").addSnapshotListener{ querySnapshot, error in
            if error != nil {
                self.delegate?.error()
            }else{
                self.rooms = []
                for document in querySnapshot!.documents{
                    let data = document.data()
                    let name = data["name"] as? String
                    let password = data["password"] as? String
                    self.rooms?.append(RoomsModel(name: name, password: password))
                }
                self.delegate?.success()
            }
        }
    }
    func addRoom(roomName:String,password:String){
        db.collection("rooms").addDocument(data: ["name":roomName,"password":password]) { error in
            if error != nil {
                self.delegate?.error()
            }else{
                print("Oda Eklendi")
            }
        }
    }
}

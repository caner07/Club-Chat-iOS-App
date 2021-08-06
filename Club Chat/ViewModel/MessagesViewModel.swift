//
//  ChatViewModel.swift
//  Club Chat
//
//  Created by Caner on 3.08.2021.
//

import Foundation
import Firebase

protocol MessagesViewModelDelegate {
    func loading()
    func success()
    func error()
}

class MessagesViewModel{
    let db = Firestore.firestore()
    var delegate:MessagesViewModelDelegate?
    var messages:[MessageModel]?
    var room:RoomsModel?
    func loadMessages(){
        db.collection(room!.name!).order(by: "date").addSnapshotListener { querySnapshot, error in
            if error != nil {
                print(error.debugDescription)
            }else{
                self.messages = []
                for document in querySnapshot!.documents{
                    let data = document.data()
                    let sender = data["sender"] as? String
                    let body = data["body"] as? String
                    let date = data["date"] as? String
                    self.messages?.append(MessageModel(sender: sender, body: body, date: date))
                }
                self.delegate?.success()
            }
        }
    }
    func sendMessage(message:String){
        let userMail = Auth.auth().currentUser?.email
        let date = Date().timeIntervalSince1970
        db.collection(room!.name!).addDocument(data: ["sender":userMail!,"body":message,"date":date]) { error in
            if error != nil {
                print(error.debugDescription)
            }else{
                self.delegate?.success()
            }
        }
    }
//    :)
    func whoSendThisMessage(index:Int)-> String{
        if Auth.auth().currentUser!.email == self.messages![index].sender {
            return "you"
        }else{
            return self.messages![index].sender!
        }
    }
}

//
//  MessagesViewController.swift
//  Club Chat
//
//  Created by Caner on 13.07.2021.
//

import UIKit

class MessagesViewController: UIViewController {
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var messageLabel: UITextField!
    let viewModel = MessagesViewModel()
    var activityView: UIActivityIndicatorView?
    var myview = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
            }
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        viewModel.delegate = self
        viewModel.loadMessages()
        self.navigationItem.title = viewModel.room?.name
        self.navigationItem.backButtonTitle = "Sohbet Odaları"
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        viewModel.sendMessage(message: messageLabel.text!)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityView = UIActivityIndicatorView(style: .large)
            self.myview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            self.myview.backgroundColor = .darkGray
            self.myview.alpha = 0.8
            self.activityView?.layer.cornerRadius = 5
            self.activityView?.center = self.view.center
            self.view.addSubview(self.myview)
            self.view.addSubview(self.activityView!)
            self.activityView?.startAnimating()
        }
        
    }

    func hideActivityIndicator(){
            DispatchQueue.main.async {
                self.activityView?.stopAnimating()
                self.myview.removeFromSuperview()
            }
    }
    func showAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Bağlantı Hatası!", message: "İnternet Bağlantınızı Kontrol Edin.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
//MARK: - UITABLEVIEWDATASOURCE,UITABLEVIEWDELEGATE
extension MessagesViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessagesTableViewCell
        cell.messageLabel.text = viewModel.messages?[indexPath.row].body
        cell.messageLabel.layer.cornerRadius = cell.messageLabel.frame.size.height / 6
        cell.messageLabel.layer.masksToBounds = true
        //Mesajı gönderen kullanıcı ise mesaj ve gönderen sağa dayalı
        if viewModel.whoSendThisMessage(index: indexPath.row) == "you" {
            cell.senderLabel.text = "Siz"
            cell.stackView.alignment = .trailing
            cell.senderLabel.textAlignment = .right
            cell.messageLabel.textAlignment = .right
            cell.messageLabel.backgroundColor = #colorLiteral(red: 0.6006183624, green: 0.7878240943, blue: 0.621578753, alpha: 1)
        }
        //Mesajı gönderen kullanıcı ise mesaj ve gönderen sola dayalı
        else{
            cell.senderLabel.text = viewModel.whoSendThisMessage(index: indexPath.row)
            cell.stackView.alignment = .leading
            cell.senderLabel.textAlignment = .left
            cell.messageLabel.textAlignment = .left
            cell.messageLabel.backgroundColor = #colorLiteral(red: 0.5435213447, green: 0.7184080482, blue: 0.9403771758, alpha: 1)
        }
        return cell
    }
   
    
    
}
//MARK: - VIEWMODEL DELEGATE
extension MessagesViewController:MessagesViewModelDelegate{
    func loading() {
        DispatchQueue.main.async {
            self.showActivityIndicator()
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            self.messageLabel.text = ""
            self.messagesTableView.reloadData()
            if self.viewModel.messages?.count != 0{
                let indexPath = IndexPath(row: (self.viewModel.messages!.count-1) , section: 0)
                self.messagesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            
        }
    }
    
    func error() {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            self.showAlert()
        }
    }
}

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
    var activityView: UIActivityIndicatorView?
    var myview = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTableView.dataSource = self
        messagesTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
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

extension MessagesViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessagesTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

//
//  RoomsViewController.swift
//  Club Chat
//
//  Created by Caner on 12.07.2021.
//

import UIKit

class RoomsViewController: UIViewController {
    @IBOutlet weak var roomsTableView: UITableView!
	var activityView: UIActivityIndicatorView?
	var myview = UIView()
	let viewModel = RoomsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		if #available(iOS 13.0, *) {
				overrideUserInterfaceStyle = .light
			}
        roomsTableView.delegate = self
        roomsTableView.dataSource = self
		viewModel.delegate = self
		viewModel.loadRooms()
    }
	@IBAction func addRoomPressed(_ sender: UIBarButtonItem) {
		let alertController = UIAlertController(title: "Sohbet Odası Ekle", message: "", preferredStyle: UIAlertController.Style.alert)
		alertController.addTextField { (textField : UITextField!) -> Void in
				textField.placeholder = "Oda İsmi(Boş Bırakılamaz)"
			}
		alertController.addTextField { (textField : UITextField!) -> Void in
			textField.placeholder = "Parola(Boş Bırakabilirsin)"
			textField.isSecureTextEntry = true
		}
		
		let cancelAction = UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.default, handler: {(action : UIAlertAction!) -> Void in })
		
		
		let saveAction = UIAlertAction(title: "Kaydet", style: UIAlertAction.Style.default, handler: { alert -> Void in
			let nameTextField = alertController.textFields![0] as UITextField
			let passwordTextField = alertController.textFields![1] as UITextField
			var password = ""
			if !(nameTextField.text!.isEmpty) {
				let roomName = nameTextField.text!
				if passwordTextField.text == "" {
					password = "NoPassword"
				}else{
					password = passwordTextField.text!
				}
				self.viewModel.addRoom(roomName: roomName, password: password)
			}
			})
			
			
			alertController.addAction(cancelAction)
			alertController.addAction(saveAction)
			
		self.present(alertController, animated: true, completion: nil)
	}
	@IBAction func logOutPressed(_ sender: UIBarButtonItem) {
		viewModel.logOut()
		self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
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
	func showPasswordAlert(name:String,index:Int){
		let alertController = UIAlertController(title: "\(name) Odası İçin Şifre", message: "", preferredStyle: UIAlertController.Style.alert)
		alertController.addTextField { (textField : UITextField!) -> Void in
				textField.placeholder = "Şifre"
			textField.isSecureTextEntry = true
			}
		
		let cancelAction = UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.default, handler: {(action : UIAlertAction!) -> Void in })
		
		
		let saveAction = UIAlertAction(title: "Odaya Gir", style: UIAlertAction.Style.default, handler: { alert -> Void in
			let passwordTextField = alertController.textFields![0] as UITextField
			self.viewModel.checkPassword(password: passwordTextField.text!, index: index)
			
		})
			
			
			alertController.addAction(cancelAction)
			alertController.addAction(saveAction)
			
		self.present(alertController, animated: true, completion: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "roomsToChat" {
			let destination = segue.destination as! MessagesViewController
			destination.viewModel.room = self.viewModel.selectedRoom
		}
	}
}
//MARK: - UITableViewDelegate,UITableViewDataSource
extension RoomsViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.rooms?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsCell", for: indexPath) as! RoomsTableViewCell
		cell.odaIsimLabel.text = viewModel.rooms?[indexPath.row].name
		if viewModel.rooms?[indexPath.row].password == "NoPassword" {
			cell.lockImage.isHidden = true
		}
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.selectedRoom = viewModel.rooms?[indexPath.row]
		if viewModel.rooms?[indexPath.row].password == "NoPassword" {
			performSegue(withIdentifier: "roomsToChat", sender: nil)
		}else{
			showPasswordAlert(name: (viewModel.rooms?[indexPath.row].name)!, index: indexPath.row)
		}
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RoomsViewController:RoomsViewModelDelegate{
	func loading() {
		showActivityIndicator()
	}
	
	func success() {
		hideActivityIndicator()
		roomsTableView.reloadData()
	}
	
	func error() {
		hideActivityIndicator()
		showAlert()
	}
	func segueToTheChat(room: RoomsModel?) {
		performSegue(withIdentifier: "roomsToChat", sender: nil)
	}
	func wrongPassword() {
		let alert = UIAlertController(title: "Hatalı Şifre!", message: "", preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
		self.present(alert, animated: true, completion: nil)

	}
}

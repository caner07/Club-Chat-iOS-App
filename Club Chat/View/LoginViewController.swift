//
//  LoginViewController.swift
//  Club Chat
//
//  Created by Caner on 10.07.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var activityView: UIActivityIndicatorView?
    var myview = UIView()
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.delegate = self
        viewModel.checkUser()
    }
    
    func setUI(){
        passwordTextField.layer.cornerRadius = passwordTextField.frame.size.height/2
        passwordTextField.clipsToBounds = false
        passwordTextField.layer.shadowOpacity=0.2
        passwordTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
        mailTextField.layer.cornerRadius = mailTextField.frame.size.height/2
        mailTextField.clipsToBounds = false
        mailTextField.layer.shadowOpacity = 0.2
        mailTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        let mailPlaceholderText = NSAttributedString(string: "E-Mail",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        mailTextField.attributedPlaceholder = mailPlaceholderText
        let passwordPlaceHolderText = NSAttributedString(string: "Şifre", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField.attributedPlaceholder = passwordPlaceHolderText
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if mailTextField.text?.isEmpty ?? false || passwordTextField.text?.isEmpty ?? false {
            showAlert(title: "Uyarı", message: "Kullanıcı Adı Ve Şifre Boş Bırakılamaz!")
        }else{
            viewModel.login(userName: mailTextField.text!, password: passwordTextField.text!)
        }
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
    
    func showAlert(title:String,message:String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
extension LoginViewController:LoginViewModelDelegate{
    func loading() {
        showActivityIndicator()
    }
    
    func success() {
        hideActivityIndicator()
        performSegue(withIdentifier: "LoginToRooms", sender: nil)
    }
    
    func error() {
        hideActivityIndicator()
        showAlert(title: "Hata", message: "Kullanıcı Adı veya Şifre Hatalı!")

    }
}

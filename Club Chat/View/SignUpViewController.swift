//
//  SignUpViewController.swift
//  Club Chat
//
//  Created by Caner on 12.07.2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var activityView: UIActivityIndicatorView?
    var myview = UIView()
    let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.delegate = self
    }
    @IBAction func signUpClicked(_ sender: UIButton) {
        if emailTextField.text?.isEmpty ?? false || passwordTextField.text?.isEmpty ?? false {
            showAlert()
        }else{
            viewModel.signUp(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    func setUI(){
        passwordTextField.layer.cornerRadius = passwordTextField.frame.size.height/2
        passwordTextField.clipsToBounds = false
        passwordTextField.layer.shadowOpacity=0.2
        passwordTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
        emailTextField.layer.cornerRadius = emailTextField.frame.size.height/2
        emailTextField.clipsToBounds = false
        emailTextField.layer.shadowOpacity = 0.2
        emailTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        let mailPlaceholderText = NSAttributedString(string: "E-Mail",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailTextField.attributedPlaceholder = mailPlaceholderText
        let passwordPlaceHolderText = NSAttributedString(string: "Şifre", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField.attributedPlaceholder = passwordPlaceHolderText
    }
    func showAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Hata!", message: "Geçerli bir E-Mail ve Şifre Girin", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
    
}
extension SignUpViewController:SignUpViewModelDelegate{
    func loading() {
        showActivityIndicator()
    }
    
    func success() {
        hideActivityIndicator()
        self.performSegue(withIdentifier: "SignUpToRooms", sender: nil)
    }
    
    func error() {
        hideActivityIndicator()
        showAlert()
    }
    
    
}

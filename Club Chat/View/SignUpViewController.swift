//
//  SignUpViewController.swift
//  Club Chat
//
//  Created by Caner on 12.07.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func signUpClicked(_ sender: UIButton) {
    }
    
}

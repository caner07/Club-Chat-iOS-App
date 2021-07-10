//
//  LoginViewController.swift
//  Club Chat
//
//  Created by Caner on 10.07.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        // Do any additional setup after loading the view.
    }

}

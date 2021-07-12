//
//  ViewController.swift
//  Club Chat
//
//  Created by Caner on 10.07.2021.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {
    @IBOutlet weak var animText: CLTypingLabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        animText.text = "🤩Club Chat🤩"
        loginButton.layer.cornerRadius = 25.0
        signupButton.layer.cornerRadius = 25.0
    }


}


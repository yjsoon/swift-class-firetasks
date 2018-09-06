//
//  ViewController.swift
//  TasksOnFire
//
//  Created by Soon Yin Jie on 5/9/18.
//  Copyright © 2018 Tinkertanker. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signupButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Sign up", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Email address"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        let signupAction = UIAlertAction(title: "Sign up", style: .default) { (_) in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            if let email = emailField.text, let password = passwordField.text {
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if (error == nil) {
                        Auth.auth().signIn(withEmail: email, password: password, completion: nil)
                    }
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(signupAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}













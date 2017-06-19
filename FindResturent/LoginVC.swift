//
//  LoginVC.swift
//  FindResturent
//
//  Created by Md AfzaL Hossain on 3/14/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxtFld: TextFieldView!
    @IBOutlet weak var passwordTxtFld: TextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        
        if emailTxtFld.text != "" && passwordTxtFld.text != "" {
           FIRAuth.auth()?.signIn(withEmail: emailTxtFld.text!, password: passwordTxtFld.text!, completion: { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }else {
                self.performSegue(withIdentifier: "toNavVC", sender: nil)
            }
           })
        }else {
            let alert = UIAlertController(title: "Error", message: "Provide All Neccessary Info", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
    }
    
    @IBAction func loginWithFB(_ sender: Any) {
    }
    
}

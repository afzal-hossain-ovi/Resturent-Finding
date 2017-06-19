//
//  SignUpVC.swift
//  FindResturent
//
//  Created by Md AfzaL Hossain on 6/15/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit
import Firebase


class SignUpVC: UIViewController {

    @IBOutlet weak var userNameTxtFld: TextFieldView!
    @IBOutlet weak var emailTxtFld: TextFieldView!
    @IBOutlet weak var passwordTxtFld: TextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signUp(_ sender: Any) {
        let isEmailValid = isValidEmail(testStr: emailTxtFld.text!)
        if userNameTxtFld.text != "" && emailTxtFld.text != "" && passwordTxtFld.text != "" {
            if (userNameTxtFld.text?.characters.count)! > 5 {
            if isEmailValid {
                
                    FIRAuth.auth()?.createUser(withEmail: emailTxtFld.text!, password: passwordTxtFld.text!, completion: { (user, error) in
                        if error != nil {
                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                        }else {
                            let alert = UIAlertController(title: "Success", message: "Account created successfully", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                            
                            let users = ["username" : self.userNameTxtFld.text!,"email" : FIRAuth.auth()!.currentUser!.email!,"uuid":NSUUID().uuidString] as [String : Any]
                            FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("user").childByAutoId().setValue(users)
                        }
                    })
            }else {
                let alert = UIAlertController(title: "Error", message: "E-mail is not valid", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                }
            }else {
                let alert = UIAlertController(title: "Error", message: "Username must be 6 character", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        }else {
            let alert = UIAlertController(title: "Error", message: "Provide All Neccessary Info", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
       
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}

//
//  ViewController.swift
//  FindResturent
//
//  Created by Md AfzaL Hossain on 3/14/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }

    @IBAction func registerPressed(_ sender: Any) {
        
    }
}


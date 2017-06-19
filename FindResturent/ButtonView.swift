//
//  ButtonView.swift
//  FindResturent
//
//  Created by Md AfzaL Hossain on 3/14/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit

class ButtonView: UIButton {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
    }
    

}

//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Piotr Stepien on 06.10.2016.
//  Copyright © 2016 Piotr Stepien. All rights reserved.
//

import UIKit

//--------------------------------------------------------------------------------
// For using Slide Out Menu Class, change UIViewController for SlideOutMenu
//--------------------------------------------------------------------------------

class ViewController: SlideOutMenu {
    
    
    //--------------------------------------------------------------------------------
    // Test button
    //--------------------------------------------------------------------------------
    
    let button = UIButton(type: UIButtonType.contactAdd)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyan
        self.view.addSubview(button)
        button.center = self.view.center
    }




}


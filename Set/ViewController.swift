//
//  ViewController.swift
//  Set
//
//  Created by Asal 3 on 04/10/2020.
//  Copyright © 2020 Asal 3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBOutlet var cardButtons: [UIButton]!
  
    @IBAction func touchCard(_ sender: UIButton) {
        sender.setTitle("△", for: UIControl.State.normal)

    }
    
}


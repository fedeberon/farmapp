//
//  SecondViewController.swift
//  farmapp
//
//  Created by Fede Beron on 08/07/2020.
//  Copyright © 2020 Fede Beron. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var ideaas: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
 ideaas.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
 ideaas.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
 ideaas.layer.shadowOpacity = 1.0
 ideaas.layer.shadowRadius = 2.0
 ideaas.layer.masksToBounds = false
 ideaas.layer.cornerRadius = 4.0
    }


}


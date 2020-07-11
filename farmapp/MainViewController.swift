//
//  MainViewController.swift
//  farmapp
//
//  Created by Fede Beron on 10/07/2020.
//  Copyright © 2020 Fede Beron. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //tabBar.barTintColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha: 1)
        // Do any additional setup after loading the view.
    }
    

    func setupTabBat() {
        let firstController = UINavigationController(rootViewController: FirstViewController())
        firstController.tabBarItem.image = UIImage(named: "first")
        firstController.tabBarItem.selectedImage = UIImage(named: "first")
        
        let secondController = UINavigationController(rootViewController: SecondViewController())
        secondController.tabBarItem.image = UIImage(named: "second")
        firstController.tabBarItem.selectedImage = UIImage(named: "second")
        
        viewControllers = [firstController, secondController]
        
        guard let items = tabBar.items else {return}
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }

}

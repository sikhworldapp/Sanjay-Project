//
//  CustomTabBarVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 29/06/24.
//

import UIKit

class CustomTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if let items = tabBar.items, items.count > 3 {
            items[3].isEnabled = false
        }
    }
}


//
//  HomePage.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 31/05/24.
//

import UIKit

class HomePage: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    
    var stringUsername: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if lblUserName != nil
        {
            lblUserName.text = stringUsername
        }
       

        // Do any additional setup after loading the view.
    }
}

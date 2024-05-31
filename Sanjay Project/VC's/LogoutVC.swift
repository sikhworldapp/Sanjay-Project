//
//  HomePage.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 31/05/24.
//

import UIKit

class LogoutVC: UIViewController {

    @IBOutlet weak var lblLogoutMsg: UILabel!
    
    var stringUsername: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLogoutMsg.text = "Hi \(stringUsername) are you sure to Logout?"
       

        // Do any additional setup after loading the view.
    }
}

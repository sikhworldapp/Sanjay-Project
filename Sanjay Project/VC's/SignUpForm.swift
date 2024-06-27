//
//  SignUpForm.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 27/06/24.
//

import UIKit

class SignUpForm: UIViewController {

    var mobileNumber : String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isMobileComing = mobileNumber
        {
            print("i have received: \(mobileNumber)")
        }
    }
    

   
}

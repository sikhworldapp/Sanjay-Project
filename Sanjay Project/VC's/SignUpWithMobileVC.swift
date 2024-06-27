//
//  SignUpWithMobileVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 27/06/24.
//

import UIKit

class SignUpWithMobileVC: UIViewController {

    var mobileNumber = "7888732564"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSendMobile(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpForm", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SignUpForm
        {
            vc.mobileNumber = mobileNumber
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

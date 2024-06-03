//
//  ViewController.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 27/05/24.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - action methods
    @IBAction func actionSubmit(_ sender: Any) {
        
        let userNameString = txtUsername.text
        let fNameString = txtFName.text
        let lNameString = txtLName.text
        
        if (userNameString?.count ?? 0 > 0 &&
            fNameString?.count ?? 0 > 0 &&
            lNameString!.count > 0)
        {
            print("the content is : \(userNameString ?? "no value found")")
            
            performSegue(withIdentifier: SegueValues.openHomePage.rawValue, sender: nil)
            
        }
        else
        {
            print("nil found..")
            showAlert(title: "Alert", message: "Please fill all the fields correctly.")
        }
        
    }
    
    @IBAction func actionSignOut(_ sender: Any) {
        performSegue(withIdentifier: SegueValues.toLogout.rawValue, sender: nil)
    }
    
  
}


enum SegueValues: String
{
    case openHomePage = "openHomePage"
    case toLogout = "toLogout"
}


extension SignUpVC
{
    func showAlert(title: String, message: String) {
        // Step 2: Create an instance of UIAlertController
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        // Step 3: Add actions (buttons)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Code to execute when the OK button is pressed
            print("OK button tapped")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // Code to execute when the OK button is pressed
            print("cancel button tapped")
        }
        
        let proceedAction = UIAlertAction(title: "Proceed", style: .destructive) { _ in
            // Code to execute when the OK button is pressed
            print("proceedAction button tapped")
        }
        
        // Add the action to the alert controller
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)
        
        // Step 4: Present the alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Prepare wala method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier
        {
        case SegueValues.openHomePage.rawValue:
            if let vc = segue.destination as? HomePage
            {
                vc.stringUsername = txtUsername.text ?? "no name found"
            }
            
        case SegueValues.toLogout.rawValue:
            if let vc = segue.destination as? LogoutVC
            {
                vc.stringUsername = txtUsername.text ?? "no name found"
            }
        default : print("no case segue identifier found.")
        }
    }
}

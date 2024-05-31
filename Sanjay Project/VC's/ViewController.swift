//
//  ViewController.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 27/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - action methods
    
    @IBAction func actionSubmit(_ sender: Any) {
        
        let content = txtUsername.text
        
        print("the content is : \(content ?? "no value found")")
        
        performSegue(withIdentifier: SegueValues.openHomePage.rawValue, sender: nil)
    }
    
    @IBAction func actionSignOut(_ sender: Any) {
        performSegue(withIdentifier: SegueValues.toLogout.rawValue, sender: nil)
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


enum SegueValues: String
{
    case openHomePage = "openHomePage"
    case toLogout = "toLogout"
}

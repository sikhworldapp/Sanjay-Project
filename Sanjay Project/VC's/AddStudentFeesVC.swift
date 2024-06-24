//
//  AddStudentFeesVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 24/06/24.
//

import UIKit

class AddStudentFeesVC: UIViewController {

    @IBOutlet weak var txtFees: UITextField? = nil
    var string: String = ""
    var delegate: FeesAddingDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFees?.text = string
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionDone(_ sender: Any) {
        if let noNil = txtFees
        {
            if let value = noNil.text
            {
                var d = Double(value) ?? 0.0
                delegate?.feesAdded(fees: d)
                dismiss(animated: true)
            }
        }
        else{
            print("txtFees is nil...viewLoadLoad must be run before using any ui view from parent activity")
        }
       
        
    }
    
}



//
//  SecondViewController.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 14/06/24.
//

import UIKit

class CustomerAddingInCartVC: UIViewController {

    @IBOutlet weak var btnMain: UIButton!
    var titleString: String =  ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hi \(titleString)"
        btnMain.setTitle(titleString, for: .normal)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true)
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

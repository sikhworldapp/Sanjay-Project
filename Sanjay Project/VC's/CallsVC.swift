//
//  CallsVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 29/06/24.
//

import UIKit

class CallsVC: BaseViewController {

    @IBOutlet weak var constraintTopButtonViewCotent: NSLayoutConstraint!
    @IBOutlet weak var uiswitch: UISwitch!
    @IBOutlet weak var lblDarkModel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionValueChanged(_ sender: Any) {
        if uiswitch.isOn
        {
            print("is on called")
            overrideUserInterfaceStyle = .dark
        }
        else
        {
            print("is off called")
            overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewWillAppear(_ animated: Bool) { //tabs ..while swtiching tabs or hit api ...refersh UI
        print("viewWillAppear called each time u switch tabs")
        UIView.animate(withDuration: 1.0) {
            self.constraintTopButtonViewCotent.constant = 60
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) { //after vc got hidden
        UIView.animate(withDuration: 1.0) {
            self.constraintTopButtonViewCotent.constant = 20
            self.view.layoutIfNeeded()
        }
        
        print("viewDidDisappear called when got hidden after switching")
    }
    
    @IBAction func actionView(_ sender: Any) {
        print("view your msgs at here.")
    }
    
    @IBAction func actionViewContents(_ sender: Any) {
        printOut(msg: "Its printing out ...")
        showToast("Showing Calls", msg: "This is where calls will be visible.", position: .top)
    }
}

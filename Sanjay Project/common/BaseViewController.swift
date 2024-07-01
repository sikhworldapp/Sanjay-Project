//
//  BaseViewController.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 01/07/24.
//

import UIKit
import Toast

class BaseViewController: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func printOut(msg: String)
    {
        print(msg)
    }
    
    func showToast(_ titles: String, msg: String, _ img: UIImage? =  UIImage(named: "profile"), position: ToastPosition?)
    {
        self.view.makeToast(msg, duration: 2.0, position: position ?? ToastPosition.bottom,  title: titles, image: img ) { didTap in
            if didTap {
                print("completion from tap")
            } else {
                print("completion without tap")
            }
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

class BaseVC: UIViewController
{
    
}

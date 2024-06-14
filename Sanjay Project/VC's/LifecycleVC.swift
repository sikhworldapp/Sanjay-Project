//
//  LifecycleVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 14/06/24.
//

import UIKit

class LifecycleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad called")
        // Do any additional setup after loading the view.
    }
    
    //when u return back to same this vc
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear called")
    }
    
    
    //when its got hidden or overlapped
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear called.")
    }
   
    deinit{
        print("deinit")
    }
    
    @IBAction func actionClose(_ sender: Any) {
        
        UIControl().sendAction(#selector(NSXPCConnection.suspend),
                               to: UIApplication.shared, for: nil)
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

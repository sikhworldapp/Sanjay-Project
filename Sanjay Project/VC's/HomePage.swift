//
//  HomePage.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 31/05/24.
//

import UIKit

class HomePage: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var stringUsername: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
}

extension HomePage : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? HomeItemCell
        cell?.imgLogo.image = UIImage(named: "calendar")!
        cell?.lblName.text = "Sanjay \(indexPath.row)"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped: \(indexPath.row)")
    }
    
   

}



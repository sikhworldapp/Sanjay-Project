//
//  HomePage.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 31/05/24.
//

import UIKit

class HomePage: UIViewController {

    @IBOutlet weak var btnHeading: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var arrStudents = [ProductModel]()
    
    var stringUsername: String = ""
    var appConstants = AppConstants.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0)
        { [self] in
            appConstants.loadStudentData()
            tableView.reloadData()
        }
       
        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func actionBackPress(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension HomePage : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? HomeItemCell
        cell?.imgLogo.image = UIImage(named: "calendar")!
        cell?.lblName.text = "\(arrStudents[indexPath.row].pName) \(indexPath.row)"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudents.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped: \(indexPath.row)")
        btnHeading.setTitle(arrStudents[indexPath.row].pName, for: .normal)
       
    }
}



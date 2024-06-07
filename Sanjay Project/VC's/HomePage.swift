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
    
    var arrStudents = [StudentModel]()
    
    var stringUsername: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0)
        {
            self.loadStudentData()
        }
       
        // Do any additional setup after loading the view.
    }
    
    func loadStudentData()
    {
        var student1 = StudentModel(name: "Sanjay", classStudent: 12, rollNo: 3, fees: 1012120.0, isPresent: true)
        var student2 = StudentModel(name: "Gaurav", classStudent: 13, rollNo: 3, fees: 1012120.0, isPresent: false)
        var student3 = StudentModel(name: "Aman", classStudent: 14, rollNo: 3, fees: 1012120.0, isPresent: true)
        
        arrStudents.append(student1)
        arrStudents.append(student2)
        arrStudents.append(student3)
        
        tableView.reloadData()
        
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
        cell?.lblName.text = "\(arrStudents[indexPath.row].name) \(indexPath.row)"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudents.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped: \(indexPath.row)")
        btnHeading.setTitle(arrStudents[indexPath.row].name, for: .normal)
       
    }
}



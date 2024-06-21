//
//  AddStudentVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 21/06/24.
//

import UIKit

class AddStudentVC: UIViewController

{
    @IBOutlet weak var pickerRollNo: UIPickerView!
    @IBOutlet weak var txtName: UITextView!
    
    var arrClass = [String]()
    var selectedClass = 5
    var newStudentModel : ((StudentModel) ->(Void))?  = nil ///Step 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerRollNo.dataSource = self
        pickerRollNo.delegate = self
        
        for i in 5...12
        {
            arrClass.append("\(i)")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionAddStudent(_ sender: Any) {
        //Step 3
        newStudentModel?(StudentModel(name: txtName.text ?? "", classStudent: selectedClass, rollNo: selectedClass, fees: 1000, isPresent: true))
        navigationController?.popViewController(animated: true)
    }
}


extension AddStudentVC : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrClass.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrClass[row]
    }
    
    // Handle the selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected item: \(arrClass[row])")
        selectedClass = Int(arrClass[row]) ?? 5
        
    }
}

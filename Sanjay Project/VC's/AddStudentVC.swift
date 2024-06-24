//
//  AddStudentVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 21/06/24.
//

import UIKit

class AddStudentVC: UIViewController, UITextViewDelegate, UITextFieldDelegate, FeesAddingDelegate
{
    func feesAdded(fees: Double) {
        print("your fees is: \(fees)")
        btnAddFees.setTitle("\(fees)", for: .normal)
    }
    
   
    @IBOutlet weak var btnAddFees: UIButton!
    @IBOutlet weak var pickerRollNo: UIPickerView!
    @IBOutlet weak var txtName: UITextView! //multiline
    @IBOutlet weak var txtRollNo: UITextField! //textfiled like edittext.android
    @IBOutlet weak var txtSchoolName: UITextField!
   
    @IBOutlet weak var viewBack: UIView!
    
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
        txtName.delegate = self
        txtSchoolName.delegate = self
        txtRollNo.delegate = self
        txtName.resignFirstResponder()
        
        viewBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddFees"
        {
            if let vc = segue.destination as? AddStudentFeesVC
            {
                vc.delegate = self
              //  vc.txtFees?.text = btnAddFees.title(for: .normal) //must not call any UI componenet in prepareSegue.
                vc.string = btnAddFees.title(for: .normal) ?? ""
            }
        }
    }
    
    @objc func hideKeyboard()
    {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtRollNo
        {
            if textField.text?.count ?? 0 > 2
            {
                return false
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
    
    @IBAction func actionDone(_ sender: Any) {
        txtRollNo.resignFirstResponder()
    }
    
    // UITextViewDelegate method
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    // Optional: Detect when return key is pressed and resign first responder
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func actionAddFees(_ sender: Any) {
        performSegue(withIdentifier: "toAddFees", sender: nil)
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

protocol FeesAddingDelegate
{
    func feesAdded(fees: Double)
}

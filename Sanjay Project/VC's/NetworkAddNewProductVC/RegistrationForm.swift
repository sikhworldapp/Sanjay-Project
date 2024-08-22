//
//  ViewController.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 27/05/24.
//

import UIKit

class RegistrationForm: BaseViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var imgEye: UIImageView!
    
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    
    var isPasswordVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDate()
        initTime()
        btnSubmit.addTapGesture {
            self.submitForm()
           
        }
        
        imgEye.addTapGesture {
            self.togglePasswordVisibility()
        }
        txtEmail.delegate = self
        txtUsername.delegate = self
        txtPassword.delegate = self
    }
    
    func initDate()
    {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        
        datePicker?.preferredDatePickerStyle = .wheels
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Example: 1 year ago from today as the minimum date
        let minDate = calendar.date(byAdding: .year, value: -1, to: currentDate)
        
        // Example: 1 year ahead from today as the maximum date
        let maxDate = calendar.date(byAdding: .year, value: 1, to: currentDate)
        
        datePicker?.minimumDate = minDate
        datePicker?.maximumDate = maxDate
        txtDate.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressedForDate))
        toolbar.setItems([doneButton], animated: true)
        
        txtDate.inputAccessoryView = toolbar
        
        // Set a default date (optional)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        txtDate.text = dateFormatter.string(from: Date())
    }
    
    @objc func donePressedForDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        // Format the selected date and set it as the text of txtDate
        txtDate.text = dateFormatter.string(from: datePicker?.date ?? Date())
        
        // Dismiss the date picker
        self.view.endEditing(true)
    }
    
    //for time:
    
    func initTime() {
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timePicker?.preferredDatePickerStyle = .wheels
        
        // Optionally set a time range if needed
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Example: Set the minimum time to 8:00 AM
        var minComponents = calendar.dateComponents([.hour, .minute], from: currentDate)
        minComponents.hour = 8
        minComponents.minute = 0
        let minTime = calendar.date(from: minComponents)
        
        // Example: Set the maximum time to 10:00 PM
        var maxComponents = calendar.dateComponents([.hour, .minute], from: currentDate)
        maxComponents.hour = 22
        maxComponents.minute = 0
        let maxTime = calendar.date(from: maxComponents)
        
        timePicker?.minimumDate = minTime
        timePicker?.maximumDate = maxTime
        
        txtTime.inputView = timePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressedForTime))
        toolbar.setItems([doneButton], animated: true)
        
        txtTime.inputAccessoryView = toolbar
        
        // Set a default time (optional)
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        txtTime.text = timeFormatter.string(from: currentDate)
    }
    
    @objc func donePressedForTime() {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        // Format the selected time and set it as the text of txtTime
        txtTime.text = timeFormatter.string(from: timePicker?.date ?? Date())
        
        // Dismiss the time picker
        self.view.endEditing(true)
    }
    
}

extension RegistrationForm: UITextFieldDelegate
{
    // UITextFieldDelegate method to handle text changes
    // UITextFieldDelegate method to handle text changes
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           
           if textField == txtEmail {
               // Allowable characters in email
               let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-_"
               let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
               let typedCharacterSet = CharacterSet(charactersIn: string)
               
               // Check if the typed characters are in the allowed set
               if !allowedCharacterSet.isSuperset(of: typedCharacterSet) {
                   return false
               }
               
               // Construct the potential new string
               let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
               
               // Validate email format (basic validation)
               if isValidEmail(newString) {
                   textField.textColor = .black
               } else {
                   textField.textColor = .red
               }
           } else if textField == txtUsername {
               // Allowable characters in username (letters, numbers, underscore, and hyphen)
               let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
               let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
               let typedCharacterSet = CharacterSet(charactersIn: string)
               
               // Check if the typed characters are in the allowed set
               if !allowedCharacterSet.isSuperset(of: typedCharacterSet) {
                   return false
               }
               
               // Optionally, you can add further validation for username, e.g., length, starting character, etc.
               textField.textColor = .black
           } else if textField == txtPassword {
               // Allowable characters in password (letters, numbers, special characters)
               let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{}|;:'\",.<>?/"
               let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
               let typedCharacterSet = CharacterSet(charactersIn: string)
               
               // Check if the typed characters are in the allowed set
               if !allowedCharacterSet.isSuperset(of: typedCharacterSet) {
                   return false
               }
               
               // Construct the potential new string
               let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
               
               // Optionally, validate password strength or other criteria
               if isValidPassword(newString) {
                   textField.textColor = .black
               } else {
                   textField.textColor = .red
               }
           }
           
           return true
       }
    
    // Function to validate password strength (basic validation)
       func isValidPassword(_ password: String) -> Bool {
           // Example criteria: At least 8 characters, contains at least one letter and one number
           let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&*()-_=+\\[\\]{}|;:'\",.<>?/]{8,}$"
           let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
           return passwordPredicate.evaluate(with: password)
       }
    
    // Function to validate email format (basic validation)
    func isValidEmail(_ email: String) -> Bool {
        // Basic regex for validating email format
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    @objc func togglePasswordVisibility() {
           // Toggle the password visibility
           isPasswordVisible.toggle()
           
           // Update the text field's secure entry status
           txtPassword.isSecureTextEntry = !isPasswordVisible
           
           // Update the eye image based on the password visibility
           updateEyeImage()
       }
       
       func updateEyeImage() {
           // Set the system image for the eye icon
           let imageName = isPasswordVisible ? "eye" : "eye.slash"
           imgEye.image = UIImage(systemName: imageName)
       }
       
    @objc func submitForm() {
           if areFieldsValid() {
               // Perform segue to the Dashboard
               self.performSegue(withIdentifier: "toDashboard", sender: nil)
           } else {
               // Optionally, show an alert or feedback to the user
               showAlert(title: "Please fill in all fields correctly.", message: "")
           }
       }
       
       func areFieldsValid() -> Bool {
           // Check if all fields are non-empty and valid
           return isValidEmail(txtEmail.text!) && !txtUsername.text!.isEmpty && isValidPassword(txtPassword.text!)
       }
}

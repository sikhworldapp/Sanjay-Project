//
//  AppConstants.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 19/06/24.
//

import Foundation

class AppConstants
{
    static var shared = AppConstants()
    private init(){
        print("initialized")
    }
    
    func loadStudentData() -> [StudentModel]
    {
        var arrStudents = [StudentModel]()
        var student1 = StudentModel(name: "Sanjay", classStudent: 12, rollNo: 3, fees: 1012120.0, isPresent: true)
        var student2 = StudentModel(name: "Gaurav", classStudent: 13, rollNo: 3, fees: 1012120.0, isPresent: false)
        var student3 = StudentModel(name: "Aman", classStudent: 14, rollNo: 3, fees: 1012120.0, isPresent: true)
        
        arrStudents.append(student1)
        arrStudents.append(student2)
        arrStudents.append(student3)
        
        return arrStudents
        
        
    }
    
}

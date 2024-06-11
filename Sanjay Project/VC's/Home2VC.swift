//
//  Home2VC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 11/06/24.
//

import UIKit

var globalModel : CellModel? = nil

class Home2VC: UIViewController {

    var name: String?
    var modelGot: CellModel? = nil
    var userDefaults = UserDefaults.standard
    
    //    Step 3
    weak var delegate: DataDelegate?
    var arr = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("name got: \(name ?? "--")")
        if let yesValuesHai = modelGot
        {
            print("getting model : \(yesValuesHai.name), \(yesValuesHai.favStatus), \(yesValuesHai.isAddedAsFrnd)")
        }
        
        if let yesValuesHai2 = globalModel
        {
            print("getting global model : \(yesValuesHai2.name), \(yesValuesHai2.favStatus), \(yesValuesHai2.isAddedAsFrnd)")
        }
        
        var nameGotFromUserDefaults = userDefaults.value(forKey: "NAME")
        print("nameGotFromUserDefaults getting: \(nameGotFromUserDefaults)")
        // Do any additional setup after loading the view.
        
        
        //STep 5
        //using delegate:
        delegate?.sendData(data: "Passed back.")
        delegate?.isReceived(value: true)
        
        arr.removeAll()
       
        arr.append(CellModel(name: "Amanpreet", img: UIImage(named: "calendar")!, favStatus: true, isAddedAsFrnd: true))
        delegate?.updateArray(arr: arr)
        
        
        
    }
}

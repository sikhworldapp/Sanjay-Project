//
//  ChooseProductVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 04/07/24.
//

import UIKit

class ChooseProductVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imgDownArrow: UIImageView!
    @IBOutlet weak var tableViewProducts: UITableView!
    @IBOutlet weak var tfProdName: UITextField!
    @IBOutlet weak var tfQuantity: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfUnit: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
   
    
    var arrProducts = [ProductModel](){
        didSet{
            print("didSet set of arrProducts just called.")
            tableViewProducts.reloadData()
        }
    }
    
    var filteredProducts = [ProductModel]()
    {
        willSet{
            print("will set of filteredProducts just called.")
            tableViewProducts.reloadData()
        }
        didSet{
            print("didSet set of filteredProducts just called.")
            tableViewProducts.reloadData()
        }
    }
    
    var tappedIndex = 0
    
    var crossImg = UIImage(systemName: "xmark.circle.fill")
    var downArrowImg = UIImage(systemName: "arrow.down.circle.fill")
    var newProductAdded: ((ProductModel) ->())? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProducts.isHidden = true
        
        imgDownArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleTable)))
        
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
        tfProdName.delegate = self
        tfQuantity.delegate = self
        
        arrProducts.append(contentsOf: AppConstants.shared.loadProducts())
        filteredProducts.append(contentsOf: arrProducts)
        
        
     }
    
    @IBAction func actionDoneAdding(_ sender: Any) {
        newProductAdded!(filteredProducts[tappedIndex])
        navigationController?.popViewController(animated: true)
    }
}



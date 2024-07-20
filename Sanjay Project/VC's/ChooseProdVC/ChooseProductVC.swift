//
//  ChooseProductVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 04/07/24.
//

import UIKit

class ChooseProductVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imgDownArrow: UIImageView!
    @IBOutlet weak var tableViewProducts: UITableView!
    @IBOutlet weak var tfProdName: UITextField!
    @IBOutlet weak var tfQuantity: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfUnit: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var btnAddEditDel: UIButton!
    
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
    
    var editableProductModel : ProductModel? = nil
    
    var tappedIndex = 0
    
    var crossImg = UIImage(systemName: "xmark.circle.fill")
    var downArrowImg = UIImage(systemName: "arrow.down.circle.fill")
    var newProductAdded: ((ProductModel) ->())? = nil //will be set from previous vc..already displaying..
    var sameProductEdited: ((ProductModel) ->())? = nil //will be set from previous vc..already displaying.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProducts.isHidden = true
        
        imgDownArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleTable)))
        
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
        tfProdName.delegate = self
        tfQuantity.delegate = self
        
        arrProducts.append(contentsOf: AppConstants.shared.loadProducts())//addAll()
        filteredProducts.append(contentsOf: arrProducts)
        
        if let modelToEdit = editableProductModel
        {
            print("to edit and fill the contents.")
            tfProdName.text = modelToEdit.pName.description
            // tfUnit = modelToEdit.
            tfQuantity.text = modelToEdit.qty?.description
            tfPrice.text = modelToEdit.price.description
            tfAmount.text = modelToEdit.amount?.description
            
            btnAddEditDel.setTitle("Edit", for: .normal)
        }
        else
        {
            print("you need to select")
        }
        
        
    }
    
    @IBAction func actionDoneAdding(_ sender: Any) {
        if tappedIndex >= 0 {
            if let modelToEdit = editableProductModel
            {
                var selectedProdModel = modelToEdit
                selectedProdModel.qty = Int(tfQuantity.text ?? "1") ?? 1
                
                
                if let amountText = tfAmount.text {
                    let cleanedAmount = amountText.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
                    selectedProdModel.amount = Double(cleanedAmount) ?? 0.0
                }
                
                sameProductEdited!(selectedProdModel)
                
            }
            
            else //it will add new entry
            {
                var selectedProdModel = filteredProducts[tappedIndex]
                selectedProdModel.qty = Int(tfQuantity.text ?? "1") ?? 1
                
                
                if let amountText = tfAmount.text {
                    let cleanedAmount = amountText.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
                    selectedProdModel.amount = Double(cleanedAmount) ?? 0.0
                }
                
                
                newProductAdded!(selectedProdModel)
            }
            
            navigationController?.popViewController(animated: true)
            
        }
        
        else
        {
            showToast("Select from list first", msg: ".", position: .top)
        }
    }
}



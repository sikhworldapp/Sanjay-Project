//
//  ChooseProductVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 04/07/24.
//

import UIKit

class AddNewProductVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfProdName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var btnAddEditDel: UIButton!
    @IBOutlet weak var imgAddImage: UIImageView!
    @IBOutlet weak var imgProdImage: UIImageView!
    
    var editableProductModel : ProductModel? = nil
    
    var tappedIndex = 0
    
    var crossImg = UIImage(systemName: "xmark.circle.fill")
    var downArrowImg = UIImage(systemName: "arrow.down.circle.fill")
    var newProductAdded: ((ProductModel) ->())? = nil //will be set from previous vc..already displaying..
    var sameProductEdited: ((ProductModel) ->())? = nil //will be set from previous vc..already displaying.
    
    var prefs = UserDefaults.standard
    var encodedImgData : Data? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgAddImage.addTapGesture {
            self.openGallery()
        }
        
        checkLogicSavingProducts()
        tfPrice.delegate = self
        tfProdName.delegate = self
        view.addTapGesture {
            self.tfPrice.resignFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == tfProdName
//        {
//            if textField.text?.count ?? 0 > 2
//            {
//                return false
//            }
//        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
    
    @IBAction func actionAddNewItem(_ sender: Any) {
        CoreDataStack.shared.insertProductWithImage(pName: tfProdName.text ?? "",
                                                    price: Double(tfPrice.text ?? "0.0" ) ?? 0.0,
                                                    imageData: encodedImgData){
            
            print("done adding/saving your entry..")
            
            navigationController?.popViewController(animated: true)
        }
     
    }
    
    
    @objc func openGallery() {
        // Check if the photo library is available
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("Photo library not available")
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func checkLogicSavingProducts()
    {
        if prefs.bool(forKey: "isProductsSaved")
        {
            print("fetch from local db then")
        }
        else
        {
            print("save all products into core data..")
            let allProds = AppConstants.shared.loadProducts()
            for i in allProds
            {
                
                CoreDataStack.shared.insertProduct(model: i)
            }
            prefs.setValue(true, forKey: "isProductsSaved")
            
        }
    }
}

extension AddNewProductVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        // Get the selected image
        if let selectedImage = info[.originalImage] as? UIImage {
            imgProdImage.image = selectedImage
            
            
            if let imageData = selectedImage.pngData() {
                encodedImgData = imageData
                
                
            }
        }
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

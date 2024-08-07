//
//  ChooseProductVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 04/07/24.
//

import UIKit

class UpdateProductVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfProdName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var btnAddEditDel: UIButton!
    @IBOutlet weak var imgAddImage: UIImageView!
    @IBOutlet weak var imgProdImage: UIImageView!
    
    @IBOutlet weak var imgCross: UIImageView!
    @IBOutlet weak var lblHeadingAddNewPro: UILabel!
    @IBOutlet weak var lblAddNewItem: UILabel!
    
    var editableProductModel : ProductModel? = nil
    var itemUpdated : (()->())? = nil
    
    var tappedIndex = 0
    
    var crossImg = UIImage(systemName: "xmark.circle.fill")
    var downArrowImg = UIImage(systemName: "arrow.down.circle.fill")
    var newProductAdded: ((ProductModel) ->())? = nil //will be set from previous vc..already displaying..
    var sameProductEdited: ((ProductModel) ->())? = nil //will be set from previous vc..already displaying.
    
    var prefs = UserDefaults.standard
    var encodedImgData : Data? = nil
    var originalPname = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let model = editableProductModel
        {
            tfProdName.text = model.pName
            originalPname = model.pName
            tfPrice.text = model.price.description
            if let dataThere = model.imageData
            {
                imgProdImage.image = UIImage(data: dataThere)
                imgCross.isHidden = false
            }
            
            
        }
        
        imgAddImage.addTapGesture {
            self.openGallery()
        }
        
        checkLogicSavingProducts()
        tfPrice.delegate = self
        tfProdName.delegate = self
        view.addTapGesture {
            self.tfPrice.resignFirstResponder()
        }
        
        imgCross.addTapGesture { [weak self] in
            self?.imgProdImage.image = nil
            self?.imgCross.isHidden = true
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
    
    @IBAction func actionUpdateItem(_ sender: Any) {
        print("to udpate.")
        CoreDataStack.shared.updateProduct(oldPName: originalPname,
                                           newPName: tfProdName.text ?? "",
                                           prodImage: encodedImgData,
                                           newPrice: Double(tfPrice.text ?? "0.0" ) ?? 0.0) { isDone in
            print("isDone: \(isDone)")
            itemUpdated?()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func actionDeleteItem(_ sender: Any) {
        AppConstants.shared.showAlert(on: self, with: "Do you want to delete : \(originalPname)") { [weak self] in
            
            CoreDataStack.shared.deleteProduct(pName: self?.originalPname ?? "") {  isTrue in
                
                self?.showToast(isTrue ? "Deleted successfully" : "Some issue persists.", msg: ".", position: .top)
                
            }
               
            self?.itemUpdated?()
            self?.navigationController?.popViewController(animated: true)
            
        } noAction: {
            print("no tapped.")
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

extension UpdateProductVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        // Get the selected image
        if let selectedImage = info[.originalImage] as? UIImage {
            imgProdImage.image = selectedImage
            imgCross.isHidden = false
            
            if let imageData = selectedImage.pngData() {
                encodedImgData = imageData
                
                
            }
        }
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

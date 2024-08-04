//
//  ChooseProductVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 04/07/24.
//

import UIKit

class ListAllProductsVC: BaseViewController, UITextFieldDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableViewProducts: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    
    var prefs = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
        
        checkLogicSavingProducts()
        
        
        
        searchBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .refreshList, object: nil)
        
        
    }
    
    //Notifcation Center.
    //1. Notificatin.Name
    //2. addObserver
    //3. handleNotification reciver waht recveed parse display
    //4. Notifcation .post...culprit post, trigger, hamlaa
    //5. deinit..removeObserver
  
    
    
    @objc func handleNotification(_ notification: Notification) {
        if let array = notification.userInfo?["array"] as? [Int] {
            print("Received array: \(array as Any), count is: \(array.count)")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func actionAddNewItem(_ sender: Any) {
        performSegue(withIdentifier: "toAddNewProduct", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddNewProduct"
        {
            if let vc = segue.destination as? AddNewProductVC{
                // Step 1 //  assign Another class's vc
                vc.addedNewItem =  {
                    
                    self.loadFromDb()
                }
                
                
            }
        }
        else if segue.identifier == "toUpdateProduct"
        {
            if let vc = segue.destination as? UpdateProductVC{
                vc.editableProductModel = filteredProducts[tappedIndex]
                // Step 1 //  assign Another class's vc
                vc.itemUpdated =  {
                    
                    self.loadFromDb()
                }
                
                
            }
        }
    }
    
    
    // This method gets called whenever the text in the search bar changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is now: \(searchText)")
        
        // If searchText is empty, display all products
        if searchText.isEmpty {
            filteredProducts = arrProducts
        } else {
            // Filter products based on searchText
            filteredProducts = arrProducts.filter { product in
                return product.pName.lowercased().contains(searchText.lowercased())
            }
        }
        
        // Reload the table view with filtered data
        tableViewProducts.reloadData()
    }
    
    // This method gets called when the search button (Return key) is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide the keyboard
        searchBar.resignFirstResponder()
    }
    
    
    
    func checkLogicSavingProducts()
    {
        if prefs.bool(forKey: "isProductsSaved")
        {
            print("fetch from local db then")
            
            loadFromDb()
            
            
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
            loadFromDb()
        }
    }
    
    func loadFromDb()
    {
        print("loadFromDb")
        arrProducts.removeAll()
        filteredProducts.removeAll()
        for coreModel in CoreDataStack.shared.readAllProducts()
        {
            var prodModel = ProductModel()
            prodModel.modelType = TypeItem.prodItem
            prodModel.pName = coreModel.pName ?? ""
            prodModel.price = coreModel.price
            prodModel.imageData = coreModel.prodImage
            prodModel.id = Int(coreModel.prodId)
            arrProducts.append(prodModel)//addAll()
        }
        filteredProducts.append(contentsOf: arrProducts)
        tableViewProducts.reloadData()
    }
    
}



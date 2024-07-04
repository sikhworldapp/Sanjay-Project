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
    
    var arrProducts = [ProductModel]()
    var filteredProducts = [ProductModel]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProducts.isHidden = true
        
        
        imgDownArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleTable)))
        
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
        tfProdName.delegate = self
        
        arrProducts.append(contentsOf: AppConstants.shared.loadProducts())
        filteredProducts.append(contentsOf: arrProducts)
        tableViewProducts.reloadData()
        
     }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfProdName {
            // Create the new text string with the proposed change
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            if newText.isEmpty {
                // If the new text is empty, hide the table view and show all products
                tableViewProducts.isHidden = true
                filteredProducts.removeAll()
                filteredProducts.append(contentsOf: arrProducts)
                imgDownArrow.image = UIImage(systemName: "arrow.down.circle.fill")
            } else {
                // If the new text is not empty, filter the products and show the table view
                tableViewProducts.isHidden = false
                filteredProducts.removeAll()
                filteredProducts.append(contentsOf: arrProducts.filter { $0.pName.lowercased().contains(newText.lowercased()) })
                imgDownArrow.image = UIImage(systemName: "xmark.circle.fill")
            }
            
            // Reload the table view in both cases
            tableViewProducts.reloadData()
        }
        return true
    }

    
    @objc func toggleTable()
    {
        if imgDownArrow.image == UIImage(systemName: "xmark.circle.fill")// cross img
        {
            tableViewProducts.isHidden = true
            tfProdName.text = ""
            imgDownArrow.image = UIImage(systemName: "arrow.down.circle.fill")
            
            filteredProducts.removeAll()
            filteredProducts.append(contentsOf: arrProducts)
            tableViewProducts.reloadData()
        }
        else
        {
            tableViewProducts.isHidden = !tableViewProducts.isHidden
        }
        
    }
}

extension ChooseProductVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell?.lblProdName.text = filteredProducts[indexPath.row].pName
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped: \(indexPath.row)")
        tfProdName.text = filteredProducts[indexPath.row].pName
        imgDownArrow.image = UIImage(systemName: "xmark.circle.fill")
        tableViewProducts.isHidden = true
    }
    
}

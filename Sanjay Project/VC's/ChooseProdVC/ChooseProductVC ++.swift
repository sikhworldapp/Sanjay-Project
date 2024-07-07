//
//  CrossProductVC ++.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 07/07/24.
//

import UIKit

extension ChooseProductVC
{
    // MARK: - Searching.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfProdName {
            // Create the new text string with the proposed change
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            if newText.isEmpty {
                // If the new text is empty, hide the table view and show all products
                hideTable()
                filteredProducts.removeAll()
                filteredProducts.append(contentsOf: arrProducts)
                imgDownArrow.image = downArrowImg
            } else {
                // If the new text is not empty, filter the products and show the table view
                showTable()
                filteredProducts.removeAll()
                filteredProducts.append(contentsOf: arrProducts.filter { $0.pName.lowercased().contains(newText.lowercased()) })
                imgDownArrow.image = crossImg
            }
            
            // Reload the table view in both cases
            // tableViewProducts.reloadData()
        }
        else if textField == tfQuantity
        {
            let totalAmount = (arrProducts[tappedIndex].price) * (Double(tfQuantity.text ?? "0.0") ?? 0.0)
            tfAmount.text = "$" + String(totalAmount)
            
            
            
            let stringPcs = (Int(tfQuantity.text ?? "0") ?? 0) > 1 ? "Pcs" : "pc"
            tfUnit.text =  stringPcs
        }
        return true
    }
    
    @objc func toggleTable()
    {
        if imgDownArrow.image == crossImg// cross img
        {
            hideTable()
            tfProdName.text = ""
            imgDownArrow.image = downArrowImg
            
            filteredProducts.removeAll()
            filteredProducts.append(contentsOf: arrProducts)
            //tableViewProducts.reloadData()
        }
        else
        {
            tableViewProducts.isHidden = !tableViewProducts.isHidden
        }
    }
    
    func hideTable()
    {
        tableViewProducts.isHidden = true
    }
    
    func showTable()
    {
        tableViewProducts.isHidden = false
    }
}

// MARK: - UITableViewDataSource +  UITableViewDelegate.
extension ChooseProductVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell?.lblProdName.text = filteredProducts[indexPath.row].pName
        cell?.lblPrice.text =  "$" + String(filteredProducts[indexPath.row].price)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedIndex = indexPath.row
        print("tapped: \(indexPath.row)")
        tfProdName.text = filteredProducts[indexPath.row].pName
        imgDownArrow.image = crossImg
        hideTable()
        
        //Quantity
        print("set quantity to 1 when selected.")
        tfQuantity.text = "1"
        
        //PIECE HANDLING
        let stringPcs = (Int(tfUnit.text ?? "0") ?? 0) > 1 ? "Pcs" : "pc"
        tfUnit.text =  stringPcs
        
        //PRICE SETTING
        tfPrice.text =  "$" + String(filteredProducts[indexPath.row].price)
        
        //Total amount setting
        tfAmount.text = "$\(filteredProducts[indexPath.row].price)"
        
        tfUnit.resignFirstResponder()
        
    }
    
}


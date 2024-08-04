//
//  CrossProductVC ++.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 07/07/24.
//

import UIKit

// MARK: - UITableViewDataSource +  UITableViewDelegate.
extension ListAllProductsVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell?.lblProdName.text = filteredProducts[indexPath.row].pName
        cell?.lblPrice.text =  "$" + String(filteredProducts[indexPath.row].price)
        
        if let imageData = filteredProducts[indexPath.row].imageData {
            cell?.imgProd.image = UIImage(data: imageData)
        } else {
            // Handle the case where imageData is nil or not valid
            cell?.imgProd.image = UIImage(named: "goods") // Or set a placeholder image
        }
       
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedIndex = indexPath.row
        performSegue(withIdentifier: "toUpdateProduct", sender: nil)
    }
    
}


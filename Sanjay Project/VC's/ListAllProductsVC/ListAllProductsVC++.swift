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
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
}


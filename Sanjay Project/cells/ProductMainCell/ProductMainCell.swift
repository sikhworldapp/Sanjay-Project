//
//  ProductMainCell.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 07/07/24.
//

import UIKit

class ProductMainCell: UITableViewCell {

    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var btnEditTapped: (()->())? = nil

    @IBAction func actionEdit(_ sender: Any) {
        btnEditTapped?()
    }
    
}

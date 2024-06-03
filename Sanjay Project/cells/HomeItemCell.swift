//
//  HomeItemCell.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 03/06/24.
//

import UIKit

class HomeItemCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
        // Initialization code
    }
}

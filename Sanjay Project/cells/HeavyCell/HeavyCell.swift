//
//  HeavyCell.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 07/06/24.
//

import UIKit

class HeavyCell: UITableViewCell {

    @IBOutlet weak var imgFavorite: UIImageView!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var btnAddFrnd: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

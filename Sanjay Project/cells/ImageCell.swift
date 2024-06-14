//
//  ImageCell.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 14/06/24.
//

import UIKit
import SDWebImage


class ImageCell: UITableViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    
    static var identifier = "ImageCell"
    
    func configure(model: CellModel)
    {
        imgLogo.sd_setImage(with: URL(string: model.urlString ?? ""), placeholderImage: UIImage(named: "calendar"))
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

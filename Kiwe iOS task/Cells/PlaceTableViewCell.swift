//
//  PlaceTableViewCell.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/6/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit
import Kingfisher

class PlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeLocation: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    static let nibName = "PlaceTableViewCell"
    static let identifier = "PlaceTableViewCell"
    var imageFromWeb = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImage.kf.setImage(with: URL(string: "\(imageFromWeb)"))  }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

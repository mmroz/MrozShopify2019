//
//  ProductTableViewCell.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties

    /// The left side image view for the collection image
    @IBOutlet weak var collectionImageView: UIImageView!
    
    /// the top label for the product name
    @IBOutlet weak var nameLabel: UILabel!
    
    /// The right alligned inventory count
    @IBOutlet weak var inventoryLabel: UILabel!
    
    /// The collection name label
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//
//  Constant.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

public struct Constants {
    
    /// Format the date "yyyy-MM-dd HH:mm:ss" used globally to retrieve dates from HTTPEndpoints
    public static var httpDateFormat : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    /// All Cell identifier names
    struct CellIdentifiers {
        static let customCollectionCellIdentifier = "CustomCollectionCell"
        static let productCellIdentifier = "ProductCell"
    }
    
    /// All Nib file names
    struct Nibs {
        static let productCellNib = "ProductTableViewCell"
    }
}

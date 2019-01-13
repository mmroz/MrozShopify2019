//
//  ProductApiResponse.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

struct ProductsApiResponse {
    /// The custom collections decoded form the API response
    let products: [ProductModel]
}

// MARK: - Decodable
extension ProductsApiResponse: Decodable {
    
    // MARK: - Private enum
    
    private enum ProductsApiResponseCodingKeys: String, CodingKey {
        /// The coding key used to access the response
        case products = "products"
    }
    
    // MARK: - Init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductsApiResponseCodingKeys.self)
        
        products = try container.decode([ProductModel].self, forKey: .products)
    }
}

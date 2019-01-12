//
//  ProductOptionModel.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

public struct ProductOptionModel {
    
    // MARK: - Public Properties
    
    public var id: Int
    public var productId: Int
    public var name: String
    public var position: Int
    public var values: [String]
    
    // MARK: - Initialize
    
    init(
        id: Int,
        productId: Int,
        name: String,
        position: Int,
        values: [String]
        ) {
        self.id = id
        self.productId = productId
        self.name = name
        self.position = position
        self.values = values
    }
}

// MARK: - Decodable

extension ProductOptionModel: Decodable {
    
    // MARK: - Private Decoding keys
    
    private enum ProductOptionModelCodingKeys: String, CodingKey {
        case id         = "id"
        case productId  = "product_Id"
        case name       = "name"
        case position   = "position"
        case values     = "values"
    }
    
    // MARK: - Decodable initalizer
    
    public init(from decoder: Decoder) throws {
        let productOptionContainer = try decoder.container(keyedBy: ProductOptionModelCodingKeys.self)
        
        self.id = try productOptionContainer.decode(Int.self, forKey: .id)
        self.productId = try productOptionContainer.decode(Int.self, forKey: .productId)
        self.name = try productOptionContainer.decode(String.self, forKey: .name)
        self.position = try productOptionContainer.decode(Int.self, forKey: .position)
        self.values = try productOptionContainer.decode([String].self, forKey: .values)
    }
}

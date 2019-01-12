//
//  CollectModel.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

public struct CollectModel {

    // MARK: - Public Properties
    
    public var id: Int
    public var collectionId: Int
    public var productId: Int
    public var featured: Bool
    public var createdAt: Date
    public var updatedAt: Date
    public var position: Int
    public var sortValue: String
    
    // MARK: - Initialize
    
    init(
        id : Int,
        collectionId : Int,
        productId : Int,
        featured: Bool,
        createdAt : Date,
        updatedAt: Date,
        position: Int,
        sortValue: String
        ) {
        self.id = id
        self.collectionId = collectionId
        self.productId = productId
        self.featured = featured
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.position = position
        self.sortValue = sortValue
    }
}

// MARK: - Decodable

extension CollectModel: Decodable {
    
    // MARK: - Private Decoding keys
    
    private enum CollectModelCodingKeys: String, CodingKey {
        case id               = "id"
        case collectionId     = "collection_id"
        case productId        = "product_id"
        case featured         = "featured"
        case createdAt        = "created_at"
        case updatedAt        = "updated_at"
        case position         = "position"
        case sortValue        = "sort_value"
    }
    
    // MARK: - Decodable initalizer
    
    public init(from decoder: Decoder) throws {
        let collectContainer = try decoder.container(keyedBy: CollectModelCodingKeys.self)
        
        self.id = try collectContainer.decode(Int.self, forKey: .id)
        self.collectionId = try collectContainer.decode(Int.self, forKey: .collectionId)
        self.productId = try collectContainer.decode(Int.self, forKey: .productId)
        self.featured = try collectContainer.decode(Bool.self, forKey: .featured)
        self.createdAt = try Constants.httpDateFormat.date(from: collectContainer.decode(String.self, forKey: .createdAt)) ?? Date()
        self.updatedAt = try Constants.httpDateFormat.date(from: collectContainer.decode(String.self, forKey: .updatedAt)) ?? Date()
        self.position = try collectContainer.decode(Int.self, forKey: .position)
        self.sortValue = try collectContainer.decode(String.self, forKey: .sortValue)
    }
}

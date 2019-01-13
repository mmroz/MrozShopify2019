//
//  ProductImageModel.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation
import UIKit

// TODO - cannot subclass structs! - ImageModel
public struct ProductImageModel {
    
    // MARK: - Public Properties
    
    public var id: Int
    public var productId: Int
    public var position: Int
    public var createdAt: Date
    public var updatedAt: Date
    public var alt: URL?
    public var width: CGFloat
    public var height: CGFloat
    public var src: URL
    public var variantIds: [Int]
    public var adminGraphqlApiId: String
    
    // MARK: - Initialize
    
    init(
        id: Int,
        productId: Int,
        position: Int,
        createdAt: Date,
        updatedAt: Date,
        alt: URL?,
        width: CGFloat,
        height: CGFloat,
        src: URL,
        variantIds: [Int],
        adminGraphqlApiId: String
        ) {
        self.id = id
        self.productId = productId
        self.position = position
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.alt = alt
        self.width = width
        self.height = height
        self.src = src
        self.variantIds = variantIds
        self.adminGraphqlApiId = adminGraphqlApiId
    }
}

// MARK: - Decodable

extension ProductImageModel: Decodable {
    
    // MARK: - Private Decoding keys
    
    private enum ProductImageCodingKeys: String, CodingKey {
        case id = "id"
        case productId = "product_id"
        case position = "position"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case alt = "alt"
        case width = "width"
        case height = "height"
        case src = "src"
        case variantIds = "variant_ids"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
    
    // MARK: - Decodable initalizer
    
    public init(from decoder: Decoder) throws {
        let productImageContainer = try decoder.container(keyedBy: ProductImageCodingKeys.self)
        
        self.id = try productImageContainer.decode(Int.self, forKey: .id)
        self.productId = try productImageContainer.decode(Int.self, forKey: .productId)
        self.position = try productImageContainer.decode(Int.self, forKey: .position)
        self.createdAt = try Constants.httpDateFormat.date(from: productImageContainer.decode(String.self, forKey: .createdAt)) ?? Date()
        self.updatedAt = try Constants.httpDateFormat.date(from: productImageContainer.decode(String.self, forKey: .updatedAt)) ?? Date()
        self.alt = try productImageContainer.decode(URL?.self, forKey: .alt)
        self.width = try productImageContainer.decode(CGFloat.self, forKey: .width)
        self.height = try productImageContainer.decode(CGFloat.self, forKey: .height)
        self.src = try productImageContainer.decode(URL.self, forKey: .src)
        self.variantIds = try productImageContainer.decode([Int].self, forKey: .variantIds)
        self.adminGraphqlApiId = try productImageContainer.decode(String.self, forKey: .adminGraphqlApiId)
    }
}

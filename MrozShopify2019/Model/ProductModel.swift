//
//  ProductModel.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

public struct ProductModel {
    
    // MARK: - Public Properties
    
    public var id: Int
    public var title: String
    public var bodyHtml: String
    public var vendor: String
    public var productType: String
    public var createdAt: Date
    public var handle: String
    public var updatedAt: Date
    public var publishedAt: Date
    public var templateSuffix: String
    public var tags: String
    public var publishedScope: String
    public var adminGraphqlApiId: String
    public var variants: [ProductVariantModel]
    public var options: [ProductOptionModel]
    public var images: [ProductImageModel]
    public var image: ProductImageModel
    
    // MARK: - Initialize
    
    init(
        id: Int,
        title: String,
        bodyHtml: String,
        vendor: String,
        productType: String,
        createdAt: Date,
        handle: String,
        updatedAt: Date,
        publishedAt: Date,
        templateSuffix: String,
        tags: String,
        publishedScope: String,
        adminGraphqlApiId: String,
        variants: [ProductVariantModel],
        options: [ProductOptionModel],
        images: [ProductImageModel],
        image: ProductImageModel
        ) {
        self.id = id
        self.title = title
        self.bodyHtml = bodyHtml
        self.vendor = vendor
        self.productType = productType
        self.createdAt = createdAt
        self.handle = handle
        self.updatedAt = updatedAt
        self.publishedAt = publishedAt
        self.templateSuffix = templateSuffix
        self.tags = tags
        self.publishedScope = publishedScope
        self.adminGraphqlApiId = adminGraphqlApiId
        self.variants = variants
        self.options = options
        self.images = images
        self.image = image
    }
}

// MARK: - Decodable

extension ProductModel: Decodable {
    
    // MARK: - Private Decoding keys
    
    private enum ProductModelCodingKeys: String, CodingKey {
        case id                   = "id"
        case title                = "title"
        case bodyHtml             = "body_html"
        case vendor               = "vendor"
        case productType          = "product_type"
        case createdAt            = "created_at"
        case handle               = "handle"
        case updatedAt            = "updated_at"
        case publishedAt          = "published_at"
        case templateSuffix       = "template_suffix"
        case tags                 = "tags"
        case publishedScope       = "published_scope"
        case adminGraphqlApiId    = "admin_graphql_api_id"
        case variants             = "variants"
        case options              = "options"
        case images               = "images"
        case image                = "image"
    }
    
    // MARK: - Decodable initalizer
    
    public init(from decoder: Decoder) throws {
        let productContainer = try decoder.container(keyedBy: ProductModelCodingKeys.self)
        
        self.id = try productContainer.decode(Int.self, forKey: .id)
        self.title = try productContainer.decode(String.self, forKey: .title)
        self.bodyHtml = try productContainer.decode(String.self, forKey: .bodyHtml)
        self.vendor = try productContainer.decode(String.self, forKey: .vendor)
        self.productType = try productContainer.decode(String.self, forKey: .productType)
        self.createdAt = try Constants.httpDateFormat.date(from: productContainer.decode(String.self, forKey: .createdAt)) ?? Date()
        self.handle = try productContainer.decode(String.self, forKey: .handle)
        self.updatedAt = try Constants.httpDateFormat.date(from: productContainer.decode(String.self, forKey: .updatedAt)) ?? Date()
        self.publishedAt = try Constants.httpDateFormat.date(from: productContainer.decode(String.self, forKey: .publishedAt)) ?? Date()
        self.templateSuffix = try productContainer.decode(String.self, forKey: .templateSuffix)
        self.tags = try productContainer.decode(String.self, forKey: .tags)
        self.publishedScope = try productContainer.decode(String.self, forKey: .publishedScope)
        self.adminGraphqlApiId = try productContainer.decode(String.self, forKey: .adminGraphqlApiId)
        self.variants = try productContainer.decode([ProductVariantModel].self, forKey: .variants)
        self.options = try productContainer.decode([ProductOptionModel].self, forKey: .options)
        self.images = try productContainer.decode([ProductImageModel].self, forKey: .images)
        self.image = try productContainer.decode(ProductImageModel.self, forKey: .image)
    }
}

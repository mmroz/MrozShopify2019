//
//  CustomCollectionModel.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

struct CustomCollectionApiResponse {
    let customCollections: [CustomCollectionModel]
}

extension CustomCollectionApiResponse: Decodable {
    
    private enum CustomCollectionApiResponseCodingKeys: String, CodingKey {
        case customCollections = "custom_collections"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCollectionApiResponseCodingKeys.self)
        
        customCollections = try container.decode([CustomCollectionModel].self, forKey: .customCollections)
    }
}

public struct CustomCollectionModel {
    
    // MARK: - Public Properties
    
    public var id: Int
    public var handle: String
    public var title: String
    public var updatedAt: Date
    public var bodyHtml: String
    public var publishedAt: Date
    public var sortOrder: String
    public var templateSuffix: String
    public var publishedScope: String
    public var adminGraphqlApiId: String
    public var image : ImageModel
    
    // MARK: - Initialize
    
    init(
        id : Int,
        handle : String,
        title : String,
        updatedAt: Date,
        bodyHtml : String,
        publishedAt: Date,
        sortOrder: String,
        templateSuffix: String,
        publishedScope: String,
        adminGraphqlApiId: String,
        image: ImageModel
        ) {
        self.id = id
        self.handle = handle
        self.title = title
        self.updatedAt = updatedAt
        self.bodyHtml = bodyHtml
        self.publishedAt = publishedAt
        self.sortOrder = sortOrder
        self.templateSuffix = templateSuffix
        self.publishedScope = publishedScope
        self.adminGraphqlApiId = adminGraphqlApiId
        self.image = image
    }
}

// MARK: - Decodable

extension CustomCollectionModel: Decodable {
    
    // MARK: - Private Decoding keys
    
    private enum CustomCollectionModelCodingKeys: String, CodingKey {
        case id                    = "id"
        case handle                = "handle"
        case title                 = "title"
        case updatedAt             = "updated_at"
        case bodyHtml              = "body_html"
        case publishedAt           = "published_at"
        case sortOrder             = "sort_order"
        case templateSuffix        = "template_suffix"
        case publishedScope        = "published_scope"
        case adminGraphqlApiId     = "admin_graphql_api_id"
        case image                 = "image"
    }
    
    // MARK: - Decodable initalizer
    
    public init(from decoder: Decoder) throws {
        let customCollectionContainer = try decoder.container(keyedBy: CustomCollectionModelCodingKeys.self)
        
        self.id = try customCollectionContainer.decode(Int.self, forKey: .id)
        self.handle = try customCollectionContainer.decode(String.self, forKey: .handle)
        self.title = try customCollectionContainer.decode(String.self, forKey: .title)
        self.updatedAt = try Constants.httpDateFormat.date(from: customCollectionContainer.decode(String.self, forKey: .updatedAt)) ?? Date()
        self.bodyHtml = try customCollectionContainer.decode(String.self, forKey: .bodyHtml)
        self.publishedAt = try Constants.httpDateFormat.date(from: customCollectionContainer.decode(String.self, forKey: .publishedAt)) ?? Date()
        self.sortOrder = try customCollectionContainer.decode(String.self, forKey: .sortOrder)
        self.templateSuffix = try customCollectionContainer.decode(String.self, forKey: .templateSuffix)
        self.publishedScope = try customCollectionContainer.decode(String.self, forKey: .publishedScope)
        self.adminGraphqlApiId = try customCollectionContainer.decode(String.self, forKey: .adminGraphqlApiId)
        self.image =  try customCollectionContainer.decode(ImageModel.self, forKey: .image)
    }
}

// MARK: - Hashable

extension CustomCollectionModel: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equitable

extension CustomCollectionModel: Equatable {
    
    public static func == (lhs: CustomCollectionModel, rhs: CustomCollectionModel) -> Bool {
        return lhs.id == rhs.id
    }
}

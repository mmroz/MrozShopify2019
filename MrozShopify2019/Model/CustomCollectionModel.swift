//
//  CustomCollectionModel.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation
import UIKit

public struct CustomCollectionModel {
    
    // MARK: - Static Properties
    
    public static var dateFormatter : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    // MARK: - Public Properties
    
    public var id: Int
    public var handle: String
    public var title: String
    public var updated_at : Date
    public var body_html : String
    public var published_at : Date
    public var sort_order : String
    public var template_suffix : String
    public var published_scope : String
    public var admin_graphql_api_id : String
    
    // TODO - how to cache this
    
    public var image : UIImage
    
    // MARK: - Initialize
    
    init(
        id : Int,
        handle : String,
        title : String,
        updated_at: Date,
        body_html : String,
        published_at: Date,
        sort_order: String,
        template_suffix: String,
        published_scope: String,
        admin_graphql_api_id: String,
        image: UIImage
        ) {
        self.id = id
        self.handle = handle
        self.title = title
        self.updated_at = updated_at
        self.body_html = body_html
        self.published_at = published_at
        self.sort_order = sort_order
        self.template_suffix = template_suffix
        self.published_scope = published_scope
        self.admin_graphql_api_id = admin_graphql_api_id
        self.image = image
    }
}

// MARK: - Decodable

extension CustomCollectionModel: Decodable {
    
    // MARK: - Private Decoding keys
    
    private enum CustomCollectionModelCodingKeys: String, CodingKey {
        case id                     = "id"
        case handle                 = "handle"
        case title                  = "title"
        case updated_at             = "updated_at"
        case body_html              = "body_html"
        case published_at           = "published_at"
        case sort_order             = "sort_order"
        case template_suffix        = "template_suffix"
        case published_scope        = "published_scope"
        case admin_graphql_api_id   = "admin_graphql_api_id"
        case image                  = "image"
    }
    
    // MARK: - Decodable initalizer
    
    public init(from decoder: Decoder) throws {
        let customCollectionContainer = try decoder.container(keyedBy: CustomCollectionModelCodingKeys.self)
        
        self.id = try customCollectionContainer.decode(Int.self, forKey: .id)
        self.handle = try customCollectionContainer.decode(String.self, forKey: .handle)
        self.title = try customCollectionContainer.decode(String.self, forKey: .title)
        self.updated_at = try CustomCollectionModel.dateFormatter.date(from: customCollectionContainer.decode(String.self, forKey: .updated_at)) ?? Date()
        self.body_html = try customCollectionContainer.decode(String.self, forKey: .body_html)
        self.published_at = try CustomCollectionModel.dateFormatter.date(from: customCollectionContainer.decode(String.self, forKey: .published_at)) ?? Date()
        self.sort_order = try customCollectionContainer.decode(String.self, forKey: .sort_order)
        self.template_suffix = try customCollectionContainer.decode(String.self, forKey: .template_suffix)
        self.published_scope = try customCollectionContainer.decode(String.self, forKey: .published_scope)
        self.admin_graphql_api_id = try customCollectionContainer.decode(String.self, forKey: .admin_graphql_api_id)
        
        // TODO - Cache this from url
        self.image = UIImage()
    }
}

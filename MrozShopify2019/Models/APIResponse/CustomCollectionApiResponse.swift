//
//  CustomCollectionApiResponse.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

struct CustomCollectionApiResponse {
    /// The custom collections decoded form the API response
    let customCollections: [CustomCollectionModel]
}

// MARK: - Decodable
extension CustomCollectionApiResponse: Decodable {
    
    // MARK: - Private enum
    
    private enum CustomCollectionApiResponseCodingKeys: String, CodingKey {
        /// The coding key used to access the response
        case customCollections = "custom_collections"
    }
    
    // MARK: - Init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCollectionApiResponseCodingKeys.self)
        
        customCollections = try container.decode([CustomCollectionModel].self, forKey: .customCollections)
    }
}

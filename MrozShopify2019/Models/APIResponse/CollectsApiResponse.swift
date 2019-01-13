//
//  CollectsApiResponse.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

struct CollectsApiResponse {
    /// The custom collections decoded form the API response
    let collects: [CollectModel]
}

// MARK: - Decodable
extension CollectsApiResponse: Decodable {
    
    // MARK: - Private enum
    
    private enum CollectsApiResponseCodingKeys: String, CodingKey {
        /// The coding key used to access the response
        case collects = "collects"
    }
    
    // MARK: - Init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CollectsApiResponseCodingKeys.self)
        
        collects = try container.decode([CollectModel].self, forKey: .collects)
    }
}

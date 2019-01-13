//
//  ImageModel.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation
import UIKit

public struct ImageModel {
    
    // MARK: - Public Properties
    
    public var createdAt: Date
    public var alt: URL?
    public var width: CGFloat
    public var height: CGFloat
    public var src: URL
    
    // MARK: - Initialize
    
    init(
        createdAt: Date,
        alt: URL?,
        width: CGFloat,
        height: CGFloat,
        src: URL
        ) {
        self.createdAt = createdAt
        self.alt = alt
        self.width = width
        self.height = height
        self.src = src
    }
}

// MARK: - Decodable

extension ImageModel: Decodable {
    
    // MARK: - Private Decoding keys
    
    private enum ImageModelCodingKeys: String, CodingKey {
        case createdAt   = "created_at"
        case alt         = "alt"
        case width       = "width"
        case height      = "height"
        case src         = "src"
    }
    
    // MARK: - Decodable initalizer
    
    public init(from decoder: Decoder) throws {
        let imageContainer = try decoder.container(keyedBy: ImageModelCodingKeys.self)
        
        self.createdAt = try Constants.httpDateFormat.date(from: imageContainer.decode(String.self, forKey: .createdAt)) ?? Date()
        self.alt = try imageContainer.decode(URL?.self, forKey: .alt)
        self.width = try imageContainer.decode(CGFloat.self, forKey: .width)
        self.height = try imageContainer.decode(CGFloat.self, forKey: .height)
        self.src = try imageContainer.decode(URL.self, forKey: .src)
    }
}

//
//  ShopfiyApi.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

public enum ShopifyApi {
    /// The routing for the custom collection
    case customCollections(page: Int, accessToken: String)
    /// The routing for the collects
    case collects(collectionId: Int, page: Int, accessToken: String)
    /// The routing for the products
    case products(ids: [Int], page: Int, accessToken: String)
}

// MARK: - EndPointType

extension ShopifyApi: EndPointType {
    
    // MARK: - Static Properties
    
    public static let baseUrl : String = "https://shopicruit.myshopify.com/admin/"
    
    // MARK: - Public Properties
    
    /// The base URL to perform queries against
    public var baseURL: URL {
        guard let url = URL(string: ShopifyApi.baseUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    /// Path for each of the destination paths
    public var path: String {
        switch self {
        case .customCollections(page: _, accessToken: _):
            return "custom_collections.json"
        case .collects(collectionId: _, page: _, accessToken: _):
            return "collects.json"
        case .products(ids: _, page: _, accessToken: _):
            return "products.json"
        }
    }
    
    /// The method to use for each queries
    /// - Note: Always use GET for this API
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    /// The task constructed from the path with the parameters with the required encoding
    public var task: HTTPTask {
        switch self {
            case .customCollections(let pageNumber, let accessToken):
                return .requestWithParameters(
                    urlParameters: [
                        (name: "page", value: pageNumber ),
                        (name: "access_token", value: accessToken)
                ], encoding: .urlPercentageEncoding
                )
            case .products(let produceIds, let pageNumber, let accessToken):
                return .requestWithParameters(
                    urlParameters: [
                        (name: "ids" , value:  produceIds.map({String($0)}).joined(separator: ",") ),
                        (name: "page", value: pageNumber ),
                        (name: "access_token", value: accessToken)
                    ], encoding: .urlPercentageEncoding
                )

            case .collects(let collectionId, let pageNumber, let accessToken):
                return .requestWithParameters(
                    urlParameters: [
                        (name: "collection_id" , value: collectionId),
                        (name: "page", value: pageNumber ),
                        (name: "access_token", value: accessToken)
                    ], encoding: .urlPercentageEncoding
                )
            }
    }

    
}


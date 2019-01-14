//
//  NetworkManager.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    /// Successful Network Request
    case success
    /// Authentication error
    case authenticationError = "Not authenticated"
    /// Bad requested
    case badRequest = "Bad request"
    /// Outdated network request
    case outdated = "Outdated URL"
    /// Unknown failure
    case failed = "Network failure"
    /// No response data
    case noData = "Response with no data"
    /// Decoding error
    case unableToDecode = "Unable to decode"
}

enum NetworkResult {
    /// Successful result
    case success
    /// Failure with message
    case failure(String)
    
    // MARK: - Init
    
    init(_ response: HTTPURLResponse) {
        switch response.statusCode {
        case 200...299: self = .success
        case 401...500: self = .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: self = .failure(NetworkResponse.badRequest.rawValue)
        case 600: self =  .failure(NetworkResponse.outdated.rawValue)
        default: self =  .failure(NetworkResponse.failed.rawValue)
        }
    }
}

struct NetworkManager {
    
    // MARK: - Static Properties
    
    /// The API key for the service
    static let ShopifyApiKey = "c32313df0d0ef512ca64d5b336a0d7c6"
    
    // MARK: - Public Properties
    
    /// The router for the service
    public let router = Router<ShopifyApi>()
    
    // MARK: - Public Types
    
    /// Completion handler for the Custom Collections Array
    public typealias CustomCollectionCompeltion = (_ collections: [CustomCollectionModel]?,_ error: String?) -> ()
    
    /// Completion handler for the Custom Collect Query
    public typealias CollectsCompeltion = (_ collections: [CollectModel]?,_ error: String?) -> ()
    
    /// Completion handler for the Products Query
    public typealias ProductsCompeltion = (_ products: [ProductModel]?,_ error: String?) -> ()
    
    /// Asynchronously retrieves CustomCollections from the URL.
    /// - Note: Thread-safe.
    /// - Parameters:
    ///   - page: The page number parameter for the query
    ///   - completionHandler:
    ///     The block to invoke on the main queue with an CustomCollectionModel Array or failure reason.
    ///     The completion handler is always invoked on the main queue.
    ///     If the request completes successfully, the data is decoded and the CustomCollectionModel are returned
    ///     If the request fails, the data parameter is nil and the error parameter contain
    ///     information about the failure.
    
    public func getCustomCollections(page: Int, completion: @escaping CustomCollectionCompeltion) {
        router.request(.customCollections(page: page, accessToken: NetworkManager.ShopifyApiKey)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkResult(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(CustomCollectionApiResponse.self, from: responseData)
                        completion(apiResponse.customCollections,nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    /// Asynchronously retrieves CollectModels from the URL.
    /// - Note: Thread-safe.
    /// - Parameters:
    ///   - collectionId: The ID of the collection to query
    ///   - page: The page number parameter for the query
    ///   - completionHandler:
    ///     The block to invoke on the main queue with an CollectModel Array or failure reason.
    ///     The completion handler is always invoked on the main queue.
    ///     If the request completes successfully, the data is decoded and the CollectModel are returned
    ///     If the request fails, the data parameter is nil and the error parameter contain
    ///     information about the failure.
    
    public func getCollects(collectionId: Int, page: Int, completion: @escaping CollectsCompeltion) {
        router.request(.collects(collectionId: collectionId, page: page, accessToken: NetworkManager.ShopifyApiKey)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkResult(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(CollectsApiResponse.self, from: responseData)
                        completion(apiResponse.collects,nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    /// Asynchronously retrieves ProductModels from the URL.
    /// - Note: Thread-safe.
    /// - Parameters:
    ///   - page: The page number parameter for the query
    ///   - completionHandler:
    ///     The block to invoke on the main queue with an ProductModel Array or failure reason.
    ///     The completion handler is always invoked on the main queue.
    ///     If the request completes successfully, the data is decoded and the ProductModel are returned
    ///     If the request fails, the data parameter is nil and the error parameter contain
    ///     information about the failure.
    
    public func getProducts(productIds: [Int], page: Int, completion: @escaping ProductsCompeltion) {
        router.request(.products(ids: productIds, page: page, accessToken: NetworkManager.ShopifyApiKey)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkResult(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(ProductsApiResponse.self, from: responseData)
                        completion(apiResponse.products,nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}

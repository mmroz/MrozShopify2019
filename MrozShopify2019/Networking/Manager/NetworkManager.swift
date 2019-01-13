//
//  NetworkManager.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation


// TODO - fix this, chnage the errors and make this cleaner

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    
    static let ShopifyApiKey = "c32313df0d0ef512ca64d5b336a0d7c6"
    let router = Router<ShopifyApi>()
    
    public typealias CustomCollectionCompeltion = (_ collections: [CustomCollectionModel]?,_ error: String?) -> ()
    public typealias CollectsCompeltion = (_ collections: [CollectModel]?,_ error: String?) -> ()
    public typealias ProductsCompeltion = (_ products: [ProductModel]?,_ error: String?) -> ()
    
    func getCustomCollections(page: Int, completion: @escaping CustomCollectionCompeltion) {
        router.request(.customCollections(page: page, accessToken: NetworkManager.ShopifyApiKey)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
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
    
    func getCollects(collectionId: Int, page: Int, completion: @escaping CollectsCompeltion) {
        router.request(.collects(collectionId: collectionId, page: page, accessToken: NetworkManager.ShopifyApiKey)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
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
    
    func getProducts(productIds: [Int], page: Int, completion: @escaping ProductsCompeltion) {
        router.request(.products(ids: productIds, page: page, accessToken: NetworkManager.ShopifyApiKey)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
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

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

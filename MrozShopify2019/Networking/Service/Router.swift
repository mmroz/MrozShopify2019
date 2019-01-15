//
//  Roter.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

/// Completion handler for NetworkRouter request
public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    /// The endpoint
    associatedtype EndPoint: EndPointType
    
    /// Perform the request with the endpoint and return the completions
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    // MARK: - Private Properties
    
    /// The timeout interval for a request. Task access only.
    private let timeoutInterval: Double
    
    /// The chaching polivy for the request. Task access only.
    private let cachingPolicy: NSURLRequest.CachePolicy
    
    /// The task that performs the network calls
    private var task: URLSessionTask?
    
    // MARK: - Init
    
    /// - Parameters:
    ///   - timeoutInterval: The network timeout interval
    ///   - cachingPolicy: The network caching policy
    
    init(timeoutInterval: Double = 10.0, cachingPolicy: NSURLRequest.CachePolicy = .reloadIgnoringCacheData) {
        self.timeoutInterval = timeoutInterval
        self.cachingPolicy = cachingPolicy
    }
    
    // MARK: - Public Methods
    
    /// Performs a netwokr request for the given endpoint
    /// - Note: Thread-safe.
    /// - Parameters:
    ///   - route: The EndPoint to be queried
    ///   - completionHandler:
    ///     The block to invoke on the main queue with data and response or failure reason.
    ///     The completion handler is always invoked on the main queue.
    ///     If the request completes successfully, the data and response parameters of the completion handler block
    ///     contains the data and response respectively, and the error parameter is nil.
    ///     If the request fails, the data and response parameters are nil and the error parameter contain
    ///     information about the failure.
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: completion)
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    // MARK: - Public Methods
    
    /// Builds a request from the route.
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: cachingPolicy,
                                 timeoutInterval: timeoutInterval)
        
        request.httpMethod = route.httpMethod.rawValue
        
        switch route.task {
        case .requestWithParameters(let urlParameters, let encoding):
            do {
                try encoding.encode(urlRequest: &request, with: urlParameters)
            } catch {
                throw error
            }
        }
        return request
    }
}

//
//  Roter.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    let timeoutInterval = 10.0
    let cachingPolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
    
    private var task: URLSessionTask?
    
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

//
//  ParameterEncoding.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

enum ParameterEncodingError: Error {
    /// An error occurred retrieving the image from the network.
    case networkError(Error)
    /// The retrieved image data could not be deserialized.
    case invalidRequestURL
}

public enum ParameterEncoding : ParameterEncoder {
    
    /// URL encoding using % delimiters
    case urlPercentageEncoding
    
    // MARK: - ParameterEncoder
    
    /// Encodes the parameters into the request for the proper format
    /// - Parameters:
    ///   - urlRequest: the request to add parameters into
    ///   - parameters: optional parameters to encode
    ///   - throws ParameterEncodingError with the URL request is improperly formatted
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters?) throws {
        guard let url = urlRequest.url else { throw ParameterEncodingError.invalidRequestURL }
        
        switch self {
        case .urlPercentageEncoding:
            if let parameters = parameters,
                var urlComponents = URLComponents(url: url,
                                                  resolvingAgainstBaseURL: false), !parameters.isEmpty {
                
                urlComponents.queryItems = [URLQueryItem]()
                
                for (key,value) in parameters {
                    let queryItem = URLQueryItem(name: key,
                                                 value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
                urlRequest.url = urlComponents.url
            }
        }
    }
}

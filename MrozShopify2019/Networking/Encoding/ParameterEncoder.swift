//
//  ParameterEncoder.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

public typealias Parameters = [(name: String, value: Any)]

public protocol ParameterEncoder {
    
    /// Encodes the parameters into the request
    /// - Parameters:
    ///   - urlRequest: the request to add parameters into
    ///   - parameters: optional parameters to encode
    ///   - throws ParameterEncodingError with the URL request is improperly formatted
    func encode(urlRequest: inout URLRequest, with parameters: Parameters?) throws
}

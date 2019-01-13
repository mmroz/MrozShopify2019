//
//  EndPointType.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

protocol EndPointType {
    
    // MARK: - Public Types
    
    /// The Base URL to make requests against
    var baseURL: URL { get }
    
    /// The Path to append to the Base URL
    var path: String { get }
    
    /// The HTTP method used for the request
    var httpMethod: HTTPMethod { get }
    
    /// The task representing the encoding of the variables for the method
    var task: HTTPTask { get }
}

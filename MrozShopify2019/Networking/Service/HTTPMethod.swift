//
//  HTTPMethod.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

public enum HTTPMethod : String {
    /// Get request.
    case get     = "GET"
    /// POST request
    case post    = "POST"
    /// PUT request
    case put     = "PUT"
    /// PATCH request
    case patch   = "PATCH"
    /// DELETE request
    case delete  = "DELETE"
}

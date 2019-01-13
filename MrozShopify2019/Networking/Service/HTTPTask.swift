//
//  HTTPTask.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

public enum HTTPTask {
     /// A network request with parameters and the encodint type
    case requestWithParameters(urlParameters: Parameters?, encoding: ParameterEncoding)
}

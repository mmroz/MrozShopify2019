//
//  UIViewController+StoryboardID.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Class Properties
    
    /// Returns the name of the soryboard
    class var storyboardID : String {
        return "\(self)"
    }
    
    // MARK: - Static Methods
    
    /// Instantiates the view controller from the storyboard
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

//
//  AppStoryboard.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case Main = "Main"
    
    // MARK: - Public Properties
    
    /// The instance of the storyboard
    public var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    // MARK: - Public Methods
    
    /// Instantiates the view controller for the storyboard
    func viewController<T: UIViewController>(viewControllerClass : T.Type) -> T {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardId) as! T
    }
    
    /// Instantiates the initial view controller for the storyboard
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

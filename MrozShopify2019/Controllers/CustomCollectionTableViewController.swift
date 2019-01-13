//
//  CustomCollectionTableViewController.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import UIKit

class CustomCollectionTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    
    /// The array holding each of the custom collections
    private var customCollectionArray: [CustomCollectionModel] = []
    
    /// The top level cacher for images
    private var imageCache: [CustomCollectionModel : UIImage] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private Methods
    
    /// Initializes the views and data
    private func initialize() {
        initializeCustomCollections()
    }
    
    /// Initializes the the customCollectionsArray and reloads the table view
    /// - Parameters:
    ///   - pageNumber: The page to query defaults to page 1
    private func initializeCustomCollections(pageNumber: Int = 1) {
        networkManager.getCustomCollections(page: pageNumber) { (customCollections, error) in
            if error != nil {
                return
            }
            
            if let customCollections = customCollections {
                self.customCollectionArray = customCollections
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customCollectionArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCollection = customCollectionArray[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.CellIdentifiers.customCollectionCellIdentifier)
        cell.textLabel?.text = customCollection.title
        cell.detailTextLabel?.text = customCollection.handle
        
        if let image = imageCache[customCollection] {
            cell.imageView?.image = image
        } else {
            imageLibrary.image(at: customCollection.image.src) { (image, error) in
                self.imageCache[customCollection] = image
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customCollection = customCollectionArray[indexPath.row]
        navigateToCollectionDetailVC(customCollection: customCollection)
    }
    
    // MARK: - Navigation
    
    /// Navigates to CollectionDetailTableViewController with the CustomCollectionModel to detail
    /// - Parameters:
    ///   - pageNumber: The page to query defaults to page 1
    private func navigateToCollectionDetailVC(customCollection: CustomCollectionModel) {
        if let navigationController = self.navigationController {
            let detailVC = CollectionDetailTableViewController.instantiate(fromAppStoryboard: .Main)
            
            detailVC.initializeProducts(customCollectionId: customCollection.id)
            detailVC.collection = customCollection
            detailVC.collectionImage = imageCache[customCollection]
            
            navigationController.pushViewController(detailVC, animated: true)
        }
    }
}

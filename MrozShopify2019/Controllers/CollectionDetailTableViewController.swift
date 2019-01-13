//
//  CollectionDetailTableViewController.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import UIKit

class CollectionDetailTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    /// The collection that owns the products.
    public var collection: CustomCollectionModel? = nil
    
    /// The collection image for the custom collection.
    public var collectionImage: UIImage? = nil
    
    // MARK: - Private Properties
    
    /// The tablieview data source of the products to display.
    private var productsArray: [ProductModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productsArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.productCellIdentifier, for: indexPath) as! ProductTableViewCell
        cell.nameLabel.text = product.title
        cell.collectionNameLabel.text = collection?.title
        cell.inventoryLabel.text = String(product.totalInventory)
        
        if let collectionImage = collectionImage {
            cell.collectionImageView.image = collectionImage
        } else {
            cell.collectionImageView.image = UIImage.init(named: "PicturePlaceholder")
        }
        return cell
    }
    
    // MARK: - UITableview delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Public Methods
    
    /// Asynchronously retrieves products for a custom collection through collects
    /// - Parameters:
    ///   - customCollectionId: the custom collection to load details for
    
    public func initializeProducts(customCollectionId: Int) {
        
        // TODO - should I add cutom error handling here?
        networkManager.getCollects(collectionId: customCollectionId, page: 1) { (collects, error) in
            if error != nil {
                return
            }
            
            if let collects = collects {
                let productIds = collects.map({ $0.productId })
                
                networkManager.getProducts(productIds: productIds, page: 1, completion: { (products, error) in
                    // TODO - should I add cutom error handling here?
                    if error != nil {
                        return
                    }
                    
                    if let products = products {
                        self.productsArray = products
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Initialize the table view
    private func initialize() {
        initializeTableView()
    }
    
    /// Initialize the table view
    /// - Note: creates the tableview header as well
    private func initializeTableView() {
        tableView.register(UINib(nibName: Constants.Nibs.productCellNib, bundle: nil), forCellReuseIdentifier: Constants.CellIdentifiers.productCellIdentifier)
    }
    

}

//
//  ProductVariantModel.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-12.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation

public struct ProductVariantModel {
    
    // MARK: - Public Properties
    // TODO - should this int?
    public var id: Int
    public var productId: Int
    public var title: String
    public var price: Decimal
    public var sku: String
    public var position: Int
    public var inventoryPolicy: String
    public var option1: String
    public var option2: String?
    public var option3: String?
    public var createdAt: Date
    public var updatedAt: Date
    public var taxable: Bool
    public var barcode: String?
    // TODO - should this int?
    public var grams: Int
    public var imageId: Int?
    public var weight: Double
    public var weightUnit: UnitMass
    public var inventoryItemId: Int
    public var inventoryQuantity: Int
    public var oldInventoryQuantity: Int
    public var requiresShipping: Bool
    public var adminGraphqlApiId: String?
    
    // MARK: - Initialize
    
    init(
        id: Int,
        productId: Int,
        title: String,
        price: Decimal,
        sku: String,
        position: Int,
        inventoryPolicy: String,
        option1: String,
        option2: String?,
        option3: String?,
        createdAt: Date,
        updatedAt: Date,
        taxable: Bool,
        barcode: String?,
        grams: Int,
        imageId: Int,
        weight: Double,
        weightUnit: UnitMass,
        inventoryItemId: Int,
        inventoryQuantity: Int,
        oldInventoryQuantity: Int,
        requiresShipping: Bool,
        adminGraphqlApiId: String?
        ) {
        self.id = id
        self.productId = productId
        self.title = title
        self.price = price
        self.sku = sku
        self.position = position
        self.inventoryPolicy = inventoryPolicy
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.taxable = taxable
        self.barcode = barcode
        self.grams = grams
        self.imageId = imageId
        self.weight = weight
        self.weightUnit = weightUnit
        self.inventoryItemId = inventoryItemId
        self.inventoryQuantity = inventoryQuantity
        self.oldInventoryQuantity = oldInventoryQuantity
        self.requiresShipping = requiresShipping
        self.adminGraphqlApiId = adminGraphqlApiId
    }
}

// MARK: - Decodable

extension ProductVariantModel: Decodable {
    
    // MARK: - Private Decoding keys
    
    private enum ProductVariantModelCodingKeys: String, CodingKey {
        case id = "id"
        case productId = "product_id"
        case title = "title"
        case price = "price"
        case sku = "sku"
        case position = "position"
        case inventoryPolicy = "inventory_policy"
        case option1 = "option1"
        case option2 = "option2"
        case option3 = "option3"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxable = "taxable"
        case barcode = "barcode"
        case grams = "grams"
        case imageId = "image_id"
        case weight = "weight"
        case weightUnit = "weight_unit"
        case inventoryItemId = "inventory_item_id"
        case inventoryQuantity = "inventory_quantity"
        case oldInventoryQuantity = "old_inventory_quantity"
        case requiresShipping = "requires_shipping"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
    
    // MARK: - Decodable initalizer
    
    public init(from decoder: Decoder) throws {
        let productVariantContainer = try decoder.container(keyedBy: ProductVariantModelCodingKeys.self)
        
        self.id = try productVariantContainer.decode(Int.self, forKey: .id)
        self.productId = try productVariantContainer.decode(Int.self, forKey: .productId)
        self.title = try productVariantContainer.decode(String.self, forKey: .title)
        self.price = try Decimal(string: productVariantContainer.decode(String.self, forKey: .price)) ?? 0.0
        self.sku = try productVariantContainer.decode(String.self, forKey: .sku)
        self.position = try productVariantContainer.decode(Int.self, forKey: .position)
        self.inventoryPolicy = try productVariantContainer.decode(String.self, forKey: .inventoryPolicy)
        self.option1 = try productVariantContainer.decode(String.self, forKey: .option1)
        self.option2 = try productVariantContainer.decode(String?.self, forKey: .option2)
        self.option3 = try productVariantContainer.decode(String?.self, forKey: .option3)
        self.createdAt = try Constants.httpDateFormat.date(from: productVariantContainer.decode(String.self, forKey: .createdAt)) ?? Date()
        self.updatedAt = try Constants.httpDateFormat.date(from: productVariantContainer.decode(String.self, forKey: .updatedAt)) ?? Date()
        self.taxable = try productVariantContainer.decode(Bool.self, forKey: .taxable)
        self.barcode = try productVariantContainer.decode(String?.self, forKey: .barcode)
        self.grams = try productVariantContainer.decode(Int.self, forKey: .grams)
        self.imageId = try productVariantContainer.decode(Int?.self, forKey: .imageId)
        self.weight = try productVariantContainer.decode(Double.self, forKey: .weight)
        self.weightUnit = try UnitMass(symbol: productVariantContainer.decode(String.self, forKey: .weightUnit))
        self.inventoryItemId = try productVariantContainer.decode(Int.self, forKey: .inventoryItemId)
        self.inventoryQuantity = try productVariantContainer.decode(Int.self, forKey: .inventoryQuantity)
        self.oldInventoryQuantity = try productVariantContainer.decode(Int.self, forKey: .oldInventoryQuantity)
        self.requiresShipping = try productVariantContainer.decode(Bool.self, forKey: .requiresShipping)
        self.adminGraphqlApiId = try productVariantContainer.decode(String?.self, forKey: .adminGraphqlApiId)
    }
}

//
//  StudentModel.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 05/06/24.
//

import Foundation

struct ProductModel
{
    var id: Int?
    var modelType : TypeItem? // ledger or item product
    var ledgerType : LedgerModel?
    var pName: String
    var qty: Int? = 0
    var amount: Double? = 0.0 //its total of all same item.
    var price: Double
    var inStock: Int
    var addedByCustomer: Int
    var discountedAmount: Double? = 0.0
}

struct MainProductModel
{
    var id: Int
    var selectedProduct: ProductModel
}

enum TypeItem: String
{
    case ledger = "ledger"
    case prodItem = "prodItem"
}

//
//  StudentModel.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 05/06/24.
//

import Foundation

struct ProductModel
{
    var id: Int
    var pName: String
    var qty: Int? = 0
    var amount: Double? = 0.0 //its total of all same item.
    var price: Double
    var inStock: Int
    var addedByCustomer: Int
}

struct MainProductModel
{
    var id: Int
    var selectedProduct: ProductModel
}

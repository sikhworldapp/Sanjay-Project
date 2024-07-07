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
    var price: Double
    var inStock: Int
    var addedByCustomer: Int
}

struct MainProductModel
{
    var id: Int
    var selectedProduct: ProductModel
}

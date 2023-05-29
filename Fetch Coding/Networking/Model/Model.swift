//
//  Model.swift
//  Fetch Coding
//
//  Created by Kalyan Chakravarthy Narne on 5/23/23.
//

import Foundation
import UIKit


enum ItemCategory {
    case dessert
}

struct Item {
    let name: String
    let image: UIImage
    let id: Int
}

struct Ingredient {
    let name: String
    let quantity: String
}

struct ItemDetail {
    let name: String
    let instructions: String
    let ingredients: [Ingredient]
}

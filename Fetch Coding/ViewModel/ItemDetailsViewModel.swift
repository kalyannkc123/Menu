//
//  ItemDetailsViewModel.swift
//  Fetch Coding
//
//  Created by Kalyan Chakravarthy Narne on 5/26/23.
//

import Foundation
struct ItemDetailsViewModel {
    private let itemsInfo: ItemsInfo
    
    init(using itemsInfo: ItemsInfo = NetworkManager()){
        self.itemsInfo = itemsInfo
    }
    
    func getItemDetail(for id: Int, completion: @escaping ((ItemDetail) -> Void)) {
        itemsInfo.getItemDetails(for: id) { itemInfo in
            let filteredIngridients = itemInfo.ingredients.filter { !$0.name.isEmpty && !$0.quantity.isEmpty
            }
            let filteredItemDetails = ItemDetail(
                name: itemInfo.name,
                instructions: itemInfo.instructions,
                ingredients: filteredIngridients)
           completion(filteredItemDetails)
        }
    }
}


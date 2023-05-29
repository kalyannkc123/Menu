//
//  ItemsViewmodel.swift
//  Fetch Coding
//
//  Created by Kalyan Chakravarthy Narne on 5/25/23.
//
import Foundation
struct ItemsViewModel {
    private let itemsInfo: ItemsInfo
    
    init(using itemsInfo: ItemsInfo = NetworkManager()){
        self.itemsInfo = itemsInfo
    }
    
    func getItems(for category: ItemCategory, completion: @escaping ([Item]) -> Void ) {
        itemsInfo.getItems(for: category) { items in
            
            let sortedItems = items.filter{ !$0.name.isEmpty }.sorted { $0.name.lowercased() < $1.name.lowercased()
            }
            completion(sortedItems)
        }
    }
}


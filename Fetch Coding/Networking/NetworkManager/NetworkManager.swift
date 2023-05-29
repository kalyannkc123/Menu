//
//  NetworkManager.swift
//  Fetch Coding
//
//  Created by Kalyan Chakravarthy Narne on 5/25/23.
//

import Foundation
import UIKit

struct ItemResponse<T:Codable>: Codable {
    var meals: T
}

enum NetworkError: Error {
    case invalidResponse
}

struct NetworkManager: ItemsInfo {
    
    
    
    private let networkModel: NetworkModel
    
    init(networkModel: NetworkModel = NetworkModel()){
        self.networkModel = networkModel
    }
    
    func getItems(for category: ItemCategory, completion: @escaping ([Item]) -> Void) {
        let url = Endpoints.fetchItemsByCategory(itemCategory: category).url
        networkModel.makeRequest(at: url) { (result: Result<ItemResponse<[ItemResponseModel]>, Error>) in
            switch result {
            case .success(let response):
                let dispatchGroup = DispatchGroup()
                var items = [Item]()
                for item in response.meals {
                    dispatchGroup.enter()
                    UIImageView.downloadImage(from: item.imageURL) { image in
                        if let id = Int(item.id) {
                            let item = Item(name: item.name, image: image, id: id)
                            items.append(item)
                        }
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .global()) {
                    completion(items)
                }
                
            case .failure(let error):
                print("Error: \(error)")
                completion([])
            }
        }
    }
    
    
    
    func getItemDetails(for id: Int, completion: @escaping (ItemDetail) -> Void) {
        let url = Endpoints.fetchItemDetails(id: id).url
        networkModel.makeRequest(at: url) { (result: Result<ItemResponse<[ItemDetailsResponseModel]>, Error>) in
            switch result {
            case .success(let response):
                guard let itemDetails = response.meals.first else {
                    let empty = ItemDetail(name: " ", instructions: " ", ingredients: [])
                    completion(empty)
                    return
                }
                let ingridients = [
                    Ingredient(name: itemDetails.ingredient1 ?? "", quantity: itemDetails.measurement1 ?? ""),
                    Ingredient(name: itemDetails.ingredient2 ?? "", quantity: itemDetails.measurement2 ?? ""),
                    Ingredient(name: itemDetails.ingredient3 ?? "", quantity: itemDetails.measurement3 ?? ""),
                    Ingredient(name: itemDetails.ingredient4 ?? "", quantity: itemDetails.measurement4 ?? ""),
                    Ingredient(name: itemDetails.ingredient5 ?? "", quantity: itemDetails.measurement5 ?? ""),
                    Ingredient(name: itemDetails.ingredient6 ?? "", quantity: itemDetails.measurement6 ?? ""),
                    Ingredient(name: itemDetails.ingredient7 ?? "", quantity: itemDetails.measurement7 ?? ""),
                    Ingredient(name: itemDetails.ingredient8 ?? "", quantity: itemDetails.measurement8 ?? ""),
                    Ingredient(name: itemDetails.ingredient9 ?? "", quantity: itemDetails.measurement9 ?? ""),
                    Ingredient(name: itemDetails.ingredient10 ?? "", quantity: itemDetails.measurement10 ?? ""),
                    Ingredient(name: itemDetails.ingredient11 ?? "", quantity: itemDetails.measurement11 ?? ""),
                    Ingredient(name: itemDetails.ingredient12 ?? "", quantity: itemDetails.measurement12 ?? ""),
                    Ingredient(name: itemDetails.ingredient13 ?? "", quantity: itemDetails.measurement13 ?? ""),
                    Ingredient(name: itemDetails.ingredient14 ?? "", quantity: itemDetails.measurement14 ?? ""),
                    Ingredient(name: itemDetails.ingredient15 ?? "", quantity: itemDetails.measurement15 ?? ""),
                    Ingredient(name: itemDetails.ingredient16 ?? "", quantity: itemDetails.measurement16 ?? ""),
                    Ingredient(name: itemDetails.ingredient17 ?? "", quantity: itemDetails.measurement17 ?? ""),
                    Ingredient(name: itemDetails.ingredient18 ?? "", quantity: itemDetails.measurement18 ?? ""),
                    Ingredient(name: itemDetails.ingredient19 ?? "", quantity: itemDetails.measurement19 ?? ""),
                    Ingredient(name: itemDetails.ingredient20 ?? "", quantity: itemDetails.measurement20 ?? ""),
                ]
                
                let itemInfo = ItemDetail(name: itemDetails.name,
                                          instructions: itemDetails.instructions,
                                          ingredients: ingridients)
                completion(itemInfo)
                
            case .failure(let error):
                print("Error: \(error)")
                let empty = ItemDetail(name: " ", instructions: " ", ingredients: [])
                completion(empty)
            }
        }
    }
}


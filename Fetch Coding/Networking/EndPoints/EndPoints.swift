//
//  EndPoints.swift
//  Fetch Coding
//
//  Created by Kalyan Chakravarthy Narne on 5/23/23.
//

import Foundation

enum Endpoints: URLEndPoint {
    
    case fetchItemsByCategory(itemCategory: ItemCategory)
    case fetchItemDetails(id: Int)
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "www.themealdb.com"
    }
    
    var path: String {
        switch self {
        case .fetchItemsByCategory:
            return "/api/json/v1/1/filter.php"
        case .fetchItemDetails:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .fetchItemsByCategory(let itemCategory):
            return [URLQueryItem(name: QueryParameters.category, value: itemCategory.rawValue)]
        case .fetchItemDetails(id: let id):
            return [URLQueryItem(name: QueryParameters.id, value: String(id))]
        }
    }
    
    var url: URL {
        var urlComponent = URLComponents()
        urlComponent.host = host
        urlComponent.scheme = scheme
        urlComponent.path = path
        urlComponent.queryItems = queryItems
        return urlComponent.url!
    }
}

private enum QueryParameters {
    static let category = "c"
    static let id = "i"
}

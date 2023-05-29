//
//  ItemsInfoProtocol.swift
//  Fetch Coding
//
//  Created by Kalyan Chakravarthy Narne on 5/25/23.
//

import Foundation
protocol ItemsInfo {
    func getItems(for category: ItemCategory, completion: @escaping (([Item]) -> Void))
    func getItemDetails(for id: Int, completion: @escaping ((ItemDetail) -> Void))
}

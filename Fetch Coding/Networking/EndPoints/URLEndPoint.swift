//
//  URLEndPoint.swift
//  Fetch Coding
//
//  Created by Kalyan Chakravarthy Narne on 5/23/23.
//

import Foundation
protocol URLEndPoint {
    var scheme: String  { get }
    var host: String  { get }
    var path: String  { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL { get }
}

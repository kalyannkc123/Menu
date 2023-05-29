//
//  NetworkModel.swift
//  Fetch Coding
//
//  Created by Kalyan Chakravarthy Narne on 5/23/23.
//

import Foundation

struct NetworkModel {
    
    func makeRequest<T: Codable>(at url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for network errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check for valid HTTP response status code
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // Handle invalid response status code
                let statusCodeError = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil)
                completion(.failure(statusCodeError))
                return
            }
            
            // Check for valid data
            guard let responseData = data else {
                // Handle missing or empty data
                let missingDataError = NSError(domain: NSURLErrorDomain, code: NSURLErrorZeroByteResource, userInfo: nil)
                completion(.failure(missingDataError))
                return
            }
            
            // Decode the response data
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: responseData)
                completion(.success(responseObject))
            } catch {
                // Handle decoding error
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}

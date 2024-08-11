//
//  NetworkManager.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 11/08/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
      
      private init() {}
      let domainName = "https://app.shalinibusiness.com/InventoryManagement/"
      
      var getAllItem: String {
          return "\(domainName)getAllitem.php"
      }
    
    func hitApi(completion: @escaping (Result<NetworkResponseModel, Error>) -> Void) {
       
        
        fetchData(from: getAllItem) { (result: Result<NetworkResponseModel, Error>) in
            switch result {
            case .success(let responseModel):
                print("Data received: \(responseModel)")
                if let status = responseModel.status {
                    switch status {
                    case .bool(let boolValue):
                        print("Status is a bool: \(boolValue)")
                        if boolValue {
                            // Additional handling if needed
                        }
                    case .string(let stringValue):
                        print("Status is a string: \(stringValue)")
                    }
                }
                completion(.success(responseModel))
                
            case .failure(let error):
                print("Failed to fetch data: \(error)")
                completion(.failure(error))
            }
        }
    }

    
    func fetchData<T: Codable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}



//
//  NetworkManager.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 11/08/24.
//

import Foundation

enum Endpoint {
    case getAllItems
    case getItem(id: String)
    case updateItem(id: String)
    case insertItem
    
    var urlString: String {
        switch self {
        case .getAllItems:
            return "\(NetworkManagerService.shared.domainName)getAllitem.php"
        case .getItem(let id):
            return "\(NetworkManagerService.shared.domainName)getItem.php?id=\(id)"
        case .updateItem(let id):
            return "\(NetworkManagerService.shared.domainName)updateItem.php?id=\(id)"
        case .insertItem:
            return "\(NetworkManagerService.shared.domainName)insertItem.php"
        }
    }
}


class NetworkManagerService {
    static let shared = NetworkManagerService(session: URLSession.shared)
    
    private let session: URLSession
    
    private init(session: URLSession) {
        self.session = session
    }
    
    let domainName = "https://app.shalinibusiness.com/InventoryManagement/"
    
    // Method to fetch all items
    func fetchAllItems(completion: @escaping (Result<NetworkResponseModel, Error>) -> Void) {
        fetchData(from: Endpoint.getAllItems.urlString, completion: completion)
    }
    
    // Method to fetch a specific item
    func fetchItem(id: String, completion: @escaping (Result<Item, Error>) -> Void) {
        fetchData(from: Endpoint.getItem(id: id).urlString, completion: completion)
    }
    
    // Method to update a specific item
    func updateItem(id: String, completion: @escaping (Result<SomeResponseModel, Error>) -> Void) {
        fetchData(from: Endpoint.updateItem(id: id).urlString, completion: completion)
    }
    
    // Method to insert a new item
    func insertItem(_ item: Item, completion: @escaping (Result<SomeResponseModel, Error>) -> Void) {
        guard let url = URL(string: Endpoint.insertItem.urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(item)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(SomeResponseModel.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }
    
    private func fetchData<T: Codable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkErrorCases.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkErrorCases.noData))
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


struct SomeResponseModel: Codable {
    // Define response model fields
}

enum NetworkErrorCases: Error {
    case invalidURL
    case noData
    case serverError(statusCode: Int)
    case decodingError(Error)
    case customError(String)
}

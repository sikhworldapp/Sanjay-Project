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
    case updateItem
    case addProduct
    case deleteProduct
    case productEntry
    case GettemByName
    
    var urlString: String {
        switch self {
        case .productEntry:
            return "\(NetworkManagerService.shared.domainName)ProductEntry.php"
        case .getAllItems:
            return "\(NetworkManagerService.shared.domainName)getAllitem.php"
        case .getItem(let id):
            return "\(NetworkManagerService.shared.domainName)getItem.php?id=\(id)"
        case .updateItem:
            return "\(NetworkManagerService.shared.domainName)updateProduct.php"
        case .deleteProduct:
            return "\(NetworkManagerService.shared.domainName)deleteProduct.php"
        case .addProduct:
            return "\(NetworkManagerService.shared.domainName)AddProduct.php"
        case .GettemByName:
            return "\(NetworkManagerService.shared.domainName)GettemByName1.php"
            
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
    
    func addProduct(product: Product, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        
        guard let url = URL(string: Endpoint.addProduct.urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Append parameters to the body as key-value pairs
        let bodyString = "Name=\(product.name)&Price=\(product.price)&Date=\(product.date)"
        print("sending body: \(bodyString)")
        request.httpBody = bodyString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }
    
    func addMultiProducts(products: [Product], completion: @escaping (Result<PostResponse, Error>) -> Void) {
        
        guard let url = URL(string: Endpoint.productEntry.urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Convert the array of Product objects to JSON data
            let jsonData = try JSONEncoder().encode(products)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("JSON String: \(jsonString)") //json formatted array will be printed with dis line
                }
            
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error as Any)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            print("data is : \(data)")
            print("response si: \(response)")
            do {
                let decodedResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        task.resume()
    }

    func updateProduct(product: Product, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        
        guard let url = URL(string: Endpoint.updateItem.urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Append parameters to the body as key-value pairs
        let bodyString = "ID=\(product.id)&Name=\(product.name)&Price=\(product.price)&Date=\(product.date)"
        print("body string: \(bodyString)")
        request.httpBody = bodyString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }

    func getProductJson(name: String? = nil, id: String? = nil, completion: @escaping (Result<GetSingleReponseByName, Error>) -> Void) {
        
        guard let url = URL(string: Endpoint.GettemByName.urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Append parameters to the body as key-value pairs
        var bodyString: String = ""//0
       
        if let nameString = name
        {
            bodyString += "Name=\(nameString)"
        }
        
        if let idString = id
        {
            if bodyString.count > 0
            {
                bodyString += "&ID=\(idString)"
            }
            else{
                bodyString += "ID=\(idString)"
            }
        }
        
        
        print("body string: \(bodyString)")
        request.httpBody = bodyString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(GetSingleReponseByName.self, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }
    
    func deleteProduct(product: Product, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        
        guard let url = URL(string: Endpoint.deleteProduct.urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Append parameters to the body as key-value pairs
        let bodyString = "ID=\(product.id)"
        print("body string: \(bodyString)")
        request.httpBody = bodyString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                completion(.success(decodedResponse))
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

struct Product: Codable {
    let id: String
    let name: String
    let price: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case price = "Price"
        case date = "Date"
    }
}

struct PostResponse: Codable {
    let status: String
    let message: String
}

struct GetSingleReponseByName: Codable {
    let data: ProductWithImage?
    let status: String?
    let message: String?
}

    
struct ProductWithImage: Codable {
    let id: String?
    let name: String?
    let price: String?
    let date: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case price = "Price"
        case date = "Date"
        case image = "Image"
    }
}

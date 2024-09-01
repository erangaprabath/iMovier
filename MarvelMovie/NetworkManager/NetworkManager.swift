//
//  NetworkManager.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import Foundation

class NetworkManager <ApiProtocolType:APIProtocol>:APIClientHook{
    
    func handelServices<T:Decodable>(_ apiProtocol: ApiProtocolType) async throws -> T {
        guard var requestUrl = URLComponents(string:  apiProtocol.baseUrl.absoluteString + apiProtocol.endPoint) else {
            throw APIError.invalidURL
        }
        
        if let parameters = apiProtocol.parameters ,apiProtocol.requestMethod == .get {
            requestUrl.queryItems = parameters.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
        }
        
        guard let url = requestUrl.url else{
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiProtocol.requestMethod.rawValue
        request.allHTTPHeaderFields = apiProtocol.headers
        
        
        if let parameters = apiProtocol.parameters, apiProtocol.requestMethod != .get{
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            }catch{
                throw APIError.requestFailed
            }
        }
        print(request)
        do{
            let (data,response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else{
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else{
                throw APIError.serverError(statusCode: httpResponse.statusCode)
            }
            
            guard !data.isEmpty else{
                throw APIError.noData
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                return decodedObject
            }catch{
                throw APIError.decodingError(error: error)
            }
        }
    }
    
   
    func downloadData<T : Decodable> (endpoints: ApiProtocolType) async throws-> T{
        return try await handelServices(endpoints)
    }
    
}

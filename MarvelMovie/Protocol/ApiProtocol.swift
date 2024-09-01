//
//  ApiProtocol.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import Foundation

protocol APIProtocol{
    var baseUrl:URL{ get }
    var endPoint:String { get }
    var requestMethod:HttpMethod { get }
    var headers:[String : String]? { get }
    var parameters:[String : Any]? { get }
}

enum ApiProtocol {
    var header: [String:String]?{
        return nil
    }
    var parameter : [String : Any]? {
        return nil
    }
}

enum HttpMethod:String{
    case get = "GET"
    case post = "POST"
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case serverError(statusCode: Int)
    case noData
    case decodingError(error: Error)
    case timeout
    case networkError(error: Error)
    case unknownError
    case invalidResponse
    case tokenExpired
    case unauthorized
    

    var localizedDescription: String {
        switch self {
            case .invalidURL:
                return "The URL provided is invalid."
            case .requestFailed:
                return "The request failed to complete."
            case .serverError(let statusCode):
                return "Server responded with an error. Status code: \(statusCode)"
            case .noData:
                return "No data was returned by the server."
            case .decodingError(let error):
                return "Failed to decode the response data: \(error.localizedDescription)"
            case .timeout:
                return "The request timed out."
            case .networkError(let error):
                return "Network error occurred: \(error.localizedDescription)"
            case .unknownError:
                return "An unknown error occurred."
            case .invalidResponse:
                return "Response is not valid"
            case .tokenExpired:
                return "Tokem expired"
            case .unauthorized:
                return "Token in valid"
        }
    }
}

extension APIError {

    static func fromURLSessionError(_ error: URLError) -> APIError {
        switch error.code {
        case .notConnectedToInternet, .networkConnectionLost:
            return .networkError(error: error)
        case .timedOut:
            return .timeout
        default:
            return .unknownError
        }
    }
}

protocol APIClientHook{
    associatedtype apiProtocolType:APIProtocol
    func handelServices<T:Decodable>(_ apiProtocol:apiProtocolType) async throws ->T
}

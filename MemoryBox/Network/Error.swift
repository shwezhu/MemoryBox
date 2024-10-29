//
//  Error.swift
//  MemoryBox
//
//  Created by David Zhu on 10/29/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case unauthorized
    case invalidCredentials
    case noToken
    case badRequest
    case invalidURL
    case serverError(statusCode: Int)
    case decodingError
    case noData
    case unknown

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Session expired. Please log in again."
        case .invalidCredentials:
            return "Invalid username or password."
        case .noToken:
            return "Authentication token not found."
        case .badRequest:
            return "Bad Request."
        case .invalidURL:
            return "Invalid URL."
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)."
        case .decodingError:
            return "Failed to decode the response."
        case .noData:
            return "No data received from the server."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}


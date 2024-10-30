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
    case invalidResponse
    case conflict
    case serverError(message: String)
    case decodingError
    case noData
    case unknown(message: String)

    var errorDescription: String {
        switch self {
        case .unauthorized:
            return "Session expired. Log in again."
        case .invalidCredentials:
            return "Invalid username or password."
        case .noToken:
            return "Token missing. Log in required."
        case .badRequest:
            return "Invalid request. Check input."
        case .invalidURL:
            return "URL is invalid."
        case .invalidResponse:
            return "Unexpected server response."
        case .conflict:
            return "Data conflict. Check input."
        case .serverError(let message):
            return "Server error: \(message)"
        case .decodingError:
            return "Decoding failed."
        case .noData:
            return "No data from server."
        case .unknown(let message):
            return "Unknown error occurred: \(message)"
        }
    }
}



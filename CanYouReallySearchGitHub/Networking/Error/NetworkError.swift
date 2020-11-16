//
//  NetworkError.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL
    case encodingFailed
    case invalidResponse
    case serializationFailure
    case urlConstructionFailure

    var localizedDescription: String {
        switch self {
        case .missingURL:
            return "The URL of the request is missing"
        case .encodingFailed:
            return "Encoding of parameters has failed"
        case .invalidResponse:
            return "Invalid request"
        case .serializationFailure:
            return "Could not decode Swift object from JSON"
        case .urlConstructionFailure:
            return "Could not create URLRequest object from provided URLRequestConvertible"
        }
    }
}

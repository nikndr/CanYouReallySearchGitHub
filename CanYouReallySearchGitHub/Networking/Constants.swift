//
//  Constants.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

struct NetworkConstants {
    static let baseURL = "https://api.github.com"
}

enum HTTPHeaderField: String {
    case auth = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case clientID = "Client-ID"
}

enum HeaderTypes: String {
    case applicationJSON = "application/json"
    case githubJSON = "application/vnd.github.v3+json"
}

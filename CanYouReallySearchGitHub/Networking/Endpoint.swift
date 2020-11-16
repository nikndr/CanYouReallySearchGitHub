//
//  Endpoint.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 11.11.2020.
//

import Foundation

protocol EndPointType {
    var path: String { get }
    var uri: String { get }
}

enum Endpoints: EndPointType {
    case fetchNextRepos
    
    static private let baseURI = "git blah blah blah"
    
    var path: String {
        switch self {
        case .fetchNextRepos:
            return "/search/repositories"
        }
    }
    
    var uri: String {
        switch self {
        case .fetchNextRepos:
            return "\(Endpoints.baseURI)\(path)"
        }
    }
}

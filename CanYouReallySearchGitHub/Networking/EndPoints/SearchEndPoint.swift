//
//  SearchEndPoint.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

enum SearchEndPoint {
    case fetchRepositories(query: String, sortBy: SortByOptions?, order: OrderOptions?, perPage: Int?, pageNumber: Int?)
}

extension SearchEndPoint: EndPointType {
    var path: String {
        switch self {
        case .fetchRepositories:
            return "/search/repositories"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchRepositories:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case let .fetchRepositories(query, sortBy, order, perPage, pageNumber):
            let parameters: OptionalParameters = [.q: query,
                                                  .sort: sortBy?.rawValue,
                                                  .order: order?.rawValue,
                                                  .perPage: perPage,
                                                  .page: pageNumber]
            return .requestWithParameters(urlParameters: URLParameterEncoder.coalesce(parameters))
        }
    }
}

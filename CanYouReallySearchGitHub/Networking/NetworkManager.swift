//
//  NetworkManager.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

final class NetworkManager: NSObject {
    func fetchRepositories(query: String,
                           sortBy: SortByOptions? = RequestConfiguration.sortBy,
                           order: OrderOptions? = RequestConfiguration.sortOrder,
                           perPage: Int? = RequestConfiguration.reposPerPage,
                           pageNumber: Int?,
                           completion: @escaping ((Result<SearchEndPointApiResponseData, NetworkError>) -> Void))
    {
        request(route: SearchEndPoint.fetchRepositories(query: query,
                                                                  sortBy: sortBy,
                                                                  order: order,
                                                                  perPage: perPage,
                                                                  pageNumber: pageNumber),
                          completion: completion)
    }
}

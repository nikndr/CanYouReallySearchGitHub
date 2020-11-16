//
//  RequestConfiguration.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Foundation

struct RequestConfiguration {
    static let reposPerPage = 30
    static let sortBy: SortByOptions = .stars
    static let sortOrder: OrderOptions = .descending
}

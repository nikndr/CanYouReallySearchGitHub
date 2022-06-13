//
//  ParameterKeys.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

/// Keys of request
enum ParameterNames: String, Hashable {
    case q
    case sort
    case order
    case perPage = "per_page"
    case page
}

enum SortByOptions: String {
    case stars
    case forks
    case helpWantedIssues = "help-wanted-issues"
    case updated = "updated"
}

enum OrderOptions: String {
    case ascending = "asc"
    case descending = "desc"
}

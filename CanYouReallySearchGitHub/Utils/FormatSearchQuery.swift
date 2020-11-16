//
//  FormatSearchQuery.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Foundation

func format(searchQuery: String) -> String {
    searchQuery.replacingOccurrences(of: " ", with: "+")
}

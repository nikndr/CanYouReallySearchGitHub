//
//  Repository.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

struct RepositoryRemote: Decodable {
    let name: String
    let owner: UserRemote
    let htmlURL: String
    let repositoryDescription: String?
    let stargazersCount: Int?
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case htmlURL = "html_url"
        case repositoryDescription = "description"
        case stargazersCount = "stargazers_count"
        case language
    }
}


//
//  Repository.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

struct RepositoryData: Decodable {
    let name: String
    let owner: UserData
    let htmlURL: String
    let repositoryDescription: String?
    let stargazersCount: Int?
    let language: String?
    var isVisited: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case htmlURL = "html_url"
        case repositoryDescription = "description"
        case stargazersCount = "stargazers_count"
        case language
    }
}


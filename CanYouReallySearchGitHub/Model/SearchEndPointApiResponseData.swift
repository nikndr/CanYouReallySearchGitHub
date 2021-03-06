//
//  ApiResponse.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 13.11.2020.
//

import Foundation

struct SearchEndPointApiResponseData: Decodable {
    let items: [RepositoryRemote]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

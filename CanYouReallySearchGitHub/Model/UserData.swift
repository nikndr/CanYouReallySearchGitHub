//
//  User.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 13.11.2020.
//

import Foundation

struct UserData: Decodable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

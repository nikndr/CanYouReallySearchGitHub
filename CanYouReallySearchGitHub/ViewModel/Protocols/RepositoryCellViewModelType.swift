//
//  CellViewModelType.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Foundation

protocol RepositoryCellViewModelType: AnyObject {
    var userName: String { get }
    var repositoryName: String { get }
    var repositoryDescription: String { get }
    var starsCount: String { get }
    var programmingLanguage: String { get }
    var urlToRepositoryPage: String { get }
    var avatarURL: String { get }
    var isVisited: Box<Bool> { get }
    func setVisited()
}

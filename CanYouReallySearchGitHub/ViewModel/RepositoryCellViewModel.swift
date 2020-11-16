//
//  RepositoryCellViewModel.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Foundation

class RepositoryCellViewModel: RepositoryCellViewModelType {
    // MARK: - Stored properties

    private var repository: Repository
    private var coreDataManager: CoreDataManager

    // MARK: - Computed properties

    var userName: String {
        repository.login!
    }

    var repositoryName: String {
        repository.name!
    }

    var repositoryDescription: String {
        repository.repositoryDescription!
    }

    var starsCount: String {
        "\(repository.stargazersCount)"
    }

    var programmingLanguage: String {
        repository.language ?? "Other"
    }

    var urlToRepositoryPage: String {
        repository.htmlURL!
    }

    var avatarURL: String {
        repository.avatarURL!
    }

    var isVisited: Observable<Bool> {
        Observable(repository.isVisited)
    }

    // MARK: - Initialization

    init(repository: Repository, coreDataManager: CoreDataManager) {
        self.repository = repository
        self.coreDataManager = coreDataManager
    }

    // MARK: - Logic

    func setVisited() {
        isVisited.value = true
        repository.isVisited = true
        coreDataManager.saveContext()
    }
}

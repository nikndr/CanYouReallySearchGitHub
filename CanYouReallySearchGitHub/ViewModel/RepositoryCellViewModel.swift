//
//  RepositoryCellViewModel.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Combine
import Foundation

class RepositoryCellViewModel: RepositoryCellViewModelType {
    // MARK: - Stored properties

    private var repository: Repository
    private var coreDataManager: CoreDataManager

    // MARK: - Computed properties

    var userName: String {
        repository.login ?? "No data"
    }

    var repositoryName: String {
        repository.name ?? "No data"
    }

    var repositoryDescription: String {
        repository.repositoryDescription ?? "No data"
    }

    var starsCount: String {
        "\(repository.stargazersCount)"
    }

    var programmingLanguage: String {
        repository.language ?? "Other"
    }

    var urlToRepositoryPage: String {
        repository.htmlURL ?? "No data"
    }

    var avatarURL: String {
        repository.avatarURL ?? "No data"
    }

    var isVisitedPublisher: AnyPublisher<Bool, Never> {
        $isVisited.eraseToAnyPublisher()
    }

    @Published var isVisited = false

    // MARK: - Initialization

    init(repository: Repository, coreDataManager: CoreDataManager) {
        self.repository = repository
        self.coreDataManager = coreDataManager
    }

    // MARK: - Logic

    func setVisited() {
        isVisited = true
        repository.isVisited = true
        coreDataManager.saveContext()
    }
}

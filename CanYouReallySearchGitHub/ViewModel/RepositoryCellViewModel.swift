//
//  RepositoryCellViewModel.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Foundation

class RepositoryCellViewModel: RepositoryCellViewModelType {
    // MARK: - Stored properties

    private var repository: RepositoryData

    // MARK: - Computed properties

    var userName: String {
        repository.owner.login
    }

    var repositoryName: String {
        repository.name
    }

    var repositoryDescription: String {
        (repository.repositoryDescription) ?? ""
    }

    var starsCount: String {
        "\(repository.stargazersCount ?? 0)"
    }

    var programmingLanguage: String {
        repository.language ?? "Other"
    }

    var urlToRepositoryPage: String {
        repository.htmlURL
    }

    var avatarURL: String {
        repository.owner.avatarURL
    }

    var isVisited: Box<Bool> = Box(false)

    // MARK: - Initialization

    init(repository: RepositoryData) {
        self.repository = repository

        bindObservers()
    }

    // MARK: - Data binding

    func bindObservers() {
        isVisited.bind { [weak self] newValue in
            guard let self = self else { return }
            self.repository.isVisited = newValue
        }
    }

    // MARK: - Logic

    func setVisited() {
        isVisited.value = true
    }
}

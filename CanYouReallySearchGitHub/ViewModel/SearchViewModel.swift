//
//  SearchViewModel.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Foundation

enum FetchError: Error {
    case fetchLocalDataError
    case fetchRemoteDataError

    var localizedDescription: String {
        switch self {
        case .fetchLocalDataError:
            return "Error while retrieving locally saved repositories."
        case .fetchRemoteDataError:
            return "Error while searching for repositories. Try again later."
        }
    }
}

class SearchViewModel: NSObject, SearchViewModelType {
    // MARK: - Stored properties

    var canPaginate = true
    var isFetching: Observable<Bool> = Observable(false)

    private var repositories = [Repository]()
    private var viewModels = [RepositoryCellViewModel]()
    private var pageNumber = 1

    private var lastSearchQuery = ""

    // MARK: - Dependencies

    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager()

    // MARK: - Fetching search results

    func fetchLocalData(completion: @escaping (FetchError?) -> Void) {
        coreDataManager.fetchRepositories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(repositories):
                self.repositories = repositories
                self.viewModels.append(contentsOf: repositories.map { RepositoryCellViewModel(repository: $0, coreDataManager: self.coreDataManager) })
                completion(nil)
            case .failure:
                completion(.fetchLocalDataError)
            }
        }
    }

    func fetchRepositories(withRawSearchInput searchInput: String, completion: @escaping (FetchError?) -> Void) {
        guard isFetching.value == false else { return }

        let searchQuery = format(searchQuery: searchInput)
        // if new search query is different from the last one, we should start new search
        if shouldResetSearchResults(for: searchQuery) {
            resetSearchResults()
        }
        lastSearchQuery = searchQuery

        isFetching.value = true
        networkManager.fetchRepositories(query: searchQuery, pageNumber: pageNumber) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isFetching.value = false
                switch result {
                case let .success(repositoriesResponse):
                    self.save(newRepositories: repositoriesResponse.items)
                    completion(nil)
                case .failure:
                    completion(.fetchRemoteDataError)
                }
            }
        }
    }

    // MARK: - Working with data

    private func resetSearchResults() {
        do {
            try coreDataManager.deleteAllRepositories()
            updateLocalRepositories()
            pageNumber = 1
        } catch {
            debugPrint(error)
        }
    }

    private func save(newRepositories: [RepositoryRemote]) {
        do {
            try coreDataManager.saveRepositories(newRepositories)
            updateLocalRepositories()
            pageNumber += 1
            checkIfCanPaginateFurther(newRepositories)
        } catch {
            debugPrint(error)
        }
    }

    private func updateLocalRepositories() {
        coreDataManager.fetchRepositories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(repositories):
                self.repositories = repositories
                self.viewModels = repositories.map { RepositoryCellViewModel(repository: $0, coreDataManager: self.coreDataManager) }
            case let .failure(error):
                debugPrint(error)
            }
        }
    }

    private func checkIfCanPaginateFurther(_ repositories: [RepositoryRemote]) {
        canPaginate = repositories.count >= RequestConfiguration.reposPerPage
    }

    private func shouldResetSearchResults(for searchInput: String) -> Bool {
        lastSearchQuery != searchInput
    }

    // MARK: - Table View helpers

    func numberOfRows() -> Int {
        repositories.count
    }

    func cellViewModel(forRowAt indexPath: IndexPath) -> RepositoryCellViewModelType? {
        viewModels[indexPath.row]
    }
}

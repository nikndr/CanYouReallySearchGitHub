//
//  SearchViewModel.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Foundation

class SearchViewModel: NSObject, SearchViewModelType {
    // MARK: - Injected properties

    @IBOutlet var networkManager: NetworkManager!

    // MARK: - Stored properties
    var canPaginate = true
    var isFetching: Box<Bool> = Box(false)
    
    private var repositories: [RepositoryData] = []
    private var viewModels: [RepositoryCellViewModel] = []
    private var pageNumber = 1
    
    private var lastSearchQuery = ""

    // MARK: - Fetching search results

    func fetchRepositories(withRawSearchInput searchInput: String, completion: @escaping (String?) -> Void) {
        guard isFetching.value == false else { return }

        let searchQuery = format(searchQuery: searchInput)
        // if new search query is different from the last one, we should start new search
        if shouldResetSearchResults(for: searchQuery) {
            resetSearchResults()
        }
        lastSearchQuery = searchQuery

        isFetching.value = true
        networkManager.fetchRepositories(query: searchQuery, pageNumber: pageNumber) { [weak self] result in
            guard let self = self else { return }
            self.isFetching.value = false
            switch result {
            case let .success(repositoriesResponse):
                self.save(newRepositories: repositoriesResponse.items)
                completion(nil)
            case let .failure(error):
                completion(error.localizedDescription)
            }
        }
    }

    private func shouldResetSearchResults(for searchInput: String) -> Bool {
        lastSearchQuery != searchInput
    }

    func resetSearchResults() {
        repositories = []
        viewModels = []
        pageNumber = 1
    }

    func save(newRepositories: [RepositoryData]) {
        repositories.append(contentsOf: newRepositories)
        viewModels.append(contentsOf: newRepositories.map { RepositoryCellViewModel(repository: $0) })
        pageNumber += 1
        
        checkIfCanPaginateFurther(newRepositories)
    }
    
    func checkIfCanPaginateFurther(_ repositories: [RepositoryData]) {
        if repositories.count < RequestConfiguration.reposPerPage {
            canPaginate = false
        } else {
            canPaginate = true
        }
    }

    // MARK: - SearchViewModelType

    func numberOfRows() -> Int {
        repositories.count
    }

    func cellViewModel(forRowAt indexPath: IndexPath) -> RepositoryCellViewModelType? {
        viewModels[indexPath.row]
    }
}

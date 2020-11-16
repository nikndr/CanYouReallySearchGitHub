//
//  TableViewModelType.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Foundation

protocol SearchViewModelType {
    var canPaginate: Bool { get }
    var isFetching: Observable<Bool> { get }
    func numberOfRows() -> Int
    func cellViewModel(forRowAt indexPath: IndexPath) -> RepositoryCellViewModelType?
    func fetchLocalData(completion: @escaping (String?) -> Void)
    func fetchRepositories(withRawSearchInput searchInput: String, completion: @escaping (String?) -> Void)
}

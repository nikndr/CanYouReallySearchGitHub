//
//  TableViewModelType.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Foundation

protocol SearchViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forRowAt indexPath: IndexPath) -> RepositoryCellViewModelType?
}

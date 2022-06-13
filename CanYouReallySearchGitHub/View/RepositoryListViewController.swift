//
//  RepositoryListViewController.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 13.11.2020.
//

import SafariServices
import UIKit

class RepositoryListViewController: UITableViewController {
    // MARK: - Injected properties

    private let viewModel = SearchViewModel()

    // MARK: - UI properties

    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Data

    private var searchBarText: String? {
        searchController.searchBar.text
    }

    private var searchBarIsEmpty: Bool {
        guard let text = searchBarText else { return false }
        return text.isEmpty
    }

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchLocalData { [unowned self] error in
            if let error = error {
                UIAlertController.showDefaultAlert(withTitle: "Oops!", message: error.localizedDescription, presenter: self)
                return 
            }
            self.reloadDataAsync()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindData()
    }

    // MARK: - UI configuration

    func configureUI() {
        // Configure NavBar title
        navigationController?.navigationBar.prefersLargeTitles = true

        // Configure Search Controller
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Repositories"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func reloadDataAsync() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Data binding

    func bindData() {
        viewModel.isFetching.subscribe { [unowned self] isDataFetching in
            if isDataFetching == true {
                tableView.setSpinnerToBackground()
                tableView.addFooterSpinner()
            } else {
                if viewModel.numberOfRows() == 0 {
                    tableView.setEmptyMessageToBackground("Nothing here!")
                } else {
                    tableView.setBackgroundEmpty()
                }
                tableView.clearFooter()
            }
        }
    }

    // MARK: - Fetch data

    func fetchRepositories() {
        guard let searchBarText = searchBarText, searchBarText.trimmingCharacters(in: [" "]).count > 0 else { return }
        viewModel.fetchRepositories(withRawSearchInput: searchBarText) { [unowned self] error in
            if let error = error {
                UIAlertController.showDefaultAlert(withTitle: "Oops!", message: error.localizedDescription, presenter: self)
                return
            }
            self.reloadDataAsync()
        }
    }

    // MARK: - Table View Delegate

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.numberOfRows()
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cellViewModel = viewModel.cellViewModel(forRowAt: indexPath),
            let urlToRepository = URL(string: cellViewModel.urlToRepositoryPage)
        else {
            UIAlertController.showDefaultAlert(withTitle: "Oops!", message: "Repository URL is missing.", presenter: self)
            return
        }
        cellViewModel.setVisited()
        let safariViewController = SFSafariViewController(url: urlToRepository)
        present(safariViewController, animated: true)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // if at the bottom of the screen, then fetch new results
        if tableShouldBeUpdatedByScrollingDown(scrollView: scrollView) {
            fetchRepositories()
        }
    }

    private func tableShouldBeUpdatedByScrollingDown(scrollView: UIScrollView) -> Bool {
        let scrollPosition = scrollView.contentOffset.y
        let userScrolledToBottom = scrollPosition > tableView.contentSize.height - scrollView.frame.size.height
        return userScrolledToBottom && viewModel.canPaginate && viewModel.numberOfRows() > 0
    }

    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .repositoryCell) as? RepositoryCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.cellViewModel(forRowAt: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - Search Bar Delegate

extension RepositoryListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_: UISearchBar) {
        reloadDataAsync()
        fetchRepositories()
    }
}

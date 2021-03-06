//
//  RepositoryCell.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 13.11.2020.
//

import UIKit

class RepositoryCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet var userAvatarImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var repositoryNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var stargazersCountLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var seenImage: UIImageView!

    // MARK: - Data

    weak var viewModel: RepositoryCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            fillCell(withDataOf: viewModel)
            bindObservers(to: viewModel)
        }
    }

    func fillCell(withDataOf viewModel: RepositoryCellViewModelType) {
        userAvatarImage.setContentDownloaded(from: viewModel.avatarURL)
        userNameLabel.text = viewModel.userName
        repositoryNameLabel.text = viewModel.repositoryName
        descriptionLabel.text = viewModel.repositoryDescription
        stargazersCountLabel.text = viewModel.starsCount
        languageLabel.text = viewModel.programmingLanguage
    }

    func bindObservers(to viewModel: RepositoryCellViewModelType) {
        viewModel.isVisited.subscribe { [weak self] isVisited in
            guard let self = self else { return }
            isVisited ? self.showVisitedImage() : self.hideVisitedImage()
        }
    }

    func showVisitedImage() {
        UIView.transition(with: seenImage,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
                              self.seenImage.image = UIImage(systemName: "eye")?.withTintColor(.darkGray)
                          })
    }

    func hideVisitedImage() {
        seenImage.image = nil
    }
}

//
//  RepositoryCell.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 13.11.2020.
//

import Combine
import UIKit

final class RepositoryCell: UITableViewCell {
    // MARK: - UI

    private lazy var topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userAvatarImage)
        view.addSubview(userNameLabel)

        view.heightAnchor.constraint(equalToConstant: 40).isActive = true

        userAvatarImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        userAvatarImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userAvatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        userAvatarImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        userNameLabel.leadingAnchor.constraint(equalTo: userAvatarImage.trailingAnchor, constant: 5).isActive = true
        userNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 0).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()

    private lazy var userAvatarImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var userNameLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textColor = .systemGray

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var repositoryNameLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .headline)

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var bottomContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starIcon)
        view.addSubview(stargazersCountLabel)
        view.addSubview(languageIcon)
        view.addSubview(languageLabel)
        view.addSubview(seenImage)

        view.heightAnchor.constraint(equalToConstant: 30).isActive = true

        starIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        starIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        starIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        starIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        stargazersCountLabel.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 5).isActive = true
        stargazersCountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        languageIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        languageIcon.heightAnchor.constraint(equalTo: languageIcon.widthAnchor).isActive = true
        languageIcon.leadingAnchor.constraint(equalTo: stargazersCountLabel.trailingAnchor, constant: 30).isActive = true
        languageIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        languageLabel.leadingAnchor.constraint(equalTo: languageIcon.trailingAnchor, constant: 5).isActive = true
        languageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        seenImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        seenImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        seenImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        seenImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()

    private lazy var starIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "star")
        view.tintColor = .darkGray

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var stargazersCountLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textColor = .darkGray

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var languageIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.left.forwardslash.chevron.right")
        view.tintColor = .darkGray
        view.contentMode = .scaleAspectFit

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var languageLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textColor = .darkGray

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var seenImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "eye")
        view.tintColor = .darkGray
        view.contentMode = .scaleAspectFit

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.addSubview(topContentView)
        contentView.addSubview(repositoryNameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bottomContentView)

        topContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        topContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        topContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20).isActive = true

        repositoryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        repositoryNameLabel.topAnchor.constraint(equalTo: topContentView.bottomAnchor, constant: 8).isActive = true
        repositoryNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 0).isActive = true

        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: repositoryNameLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true

        bottomContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        bottomContentView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        bottomContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        bottomContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }

    // MARK: - State

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Methods

    func fillCell(withDataOf viewModel: RepositoryCellViewModelType) {
        userAvatarImage.setContentDownloaded(from: viewModel.avatarURL)
        userNameLabel.text = viewModel.userName
        repositoryNameLabel.text = viewModel.repositoryName
        descriptionLabel.text = viewModel.repositoryDescription
        stargazersCountLabel.text = viewModel.starsCount
        languageLabel.text = viewModel.programmingLanguage

        bindObservers(to: viewModel)
    }

    private func bindObservers(to viewModel: RepositoryCellViewModelType) {
        viewModel.isVisitedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isVisited in
                if isVisited {
                    self?.showVisitedImage()
                } else {
                    self?.hideVisitedImage()
                }
            }
            .store(in: &subscriptions)
    }

    private func showVisitedImage() {
        seenImage.alpha = 1
    }

    private func hideVisitedImage() {
        seenImage.alpha = 0
    }
}

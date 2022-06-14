//
//  RepositoryCell.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 13.11.2020.
//

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
        userAvatarImage.heightAnchor.constraint(equalTo: userAvatarImage.widthAnchor).isActive = true
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
        view.topAnchor.constraint(equalTo: topContentView.bottomAnchor, constant: 8).isActive = true

        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 43).isActive = true
        view.topAnchor.constraint(equalTo: repositoryNameLabel.bottomAnchor, constant: 5).isActive = true

        return view
    }()

    private lazy var bottomContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starIcon)
        view.addSubview(stargazersCountLabel)
        view.addSubview(languageIcon)
        view.addSubview(languageLabel)

        view.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true

        starIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        starIcon.heightAnchor.constraint(equalTo: starIcon.widthAnchor).isActive = true
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
        seenImage.heightAnchor.constraint(equalTo: seenImage.widthAnchor).isActive = true
        seenImage.leadingAnchor.constraint(greaterThanOrEqualTo: languageLabel.trailingAnchor, constant: 0).isActive = true
        seenImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        seenImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()

    private lazy var starIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star")?.withTintColor(.darkGray)

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
        view.image = UIImage(systemName: "chevron.left.forwardslash.chevron.right")?.withTintColor(.darkGray)
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
        view.image = UIImage(systemName: "eye")?.withTintColor(.darkGray)
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

        topContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topContentView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        repositoryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        repositoryNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 0).isActive = true

        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 0).isActive = true

        bottomContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bottomContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bottomContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }

    // MARK: - Methods

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

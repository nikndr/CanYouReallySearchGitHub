//
//  UITableViewExtension.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 14.11.2020.
//

import UIKit

enum CellIdentifiers: String {
    case repositoryCell = "RepositoryCell"
}

extension UITableView {
    func dequeueReusableCell(withIdentifier identifier: CellIdentifiers) -> UITableViewCell? {
        dequeueReusableCell(withIdentifier: identifier.rawValue)
    }

    func addFooterSpinner() {
        tableFooterView = UIActivityIndicatorView.spinnerInsideContainer(width: frame.size.width, height: 100)
    }

    func clearFooter() {
        tableFooterView = nil
    }

    func setSpinnerToBackground() {
        restoreBackground()

        backgroundView = UIActivityIndicatorView.spinnerInsideContainer(width: bounds.size.width, height: bounds.size.height)
        separatorStyle = .none
    }

    func setEmptyMessageToBackground(_ message: String) {
        restoreBackground()

        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        backgroundView = messageLabel
        separatorStyle = .none
    }

    func restoreBackground() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
}

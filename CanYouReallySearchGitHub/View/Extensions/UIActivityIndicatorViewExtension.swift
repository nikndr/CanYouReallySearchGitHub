//
//  UIActivityIndicatorViewExtension.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import UIKit

extension UIActivityIndicatorView {
    static func spinnerInsideContainer(width: CGFloat, height: CGFloat) -> UIView {
        let spinnerContainer = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let spinner = UIActivityIndicatorView()
        spinner.center = spinnerContainer.center
        spinnerContainer.addSubview(spinner)
        spinner.startAnimating()
        
        return spinnerContainer
    }
}

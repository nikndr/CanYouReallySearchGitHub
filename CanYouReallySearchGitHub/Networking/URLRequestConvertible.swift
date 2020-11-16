//
//  URLRequestConvertible.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

/// Types conforming to `URLRequestConvertible` can be represented as `URLRequest`
protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    public var urlRequest: URLRequest? {
        try? asURLRequest()
    }
}

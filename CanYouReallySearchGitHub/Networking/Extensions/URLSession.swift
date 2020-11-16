//
//  URLSession.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

typealias DataTaskCompletionHandler = (Data?, URLResponse?, Error?) -> Void

extension URLSession {
    func dataTask(with requestConvertible: URLRequestConvertible,
                  completionHandler: @escaping DataTaskCompletionHandler) throws -> URLSessionDataTask?
    {
        guard let urlRequest = try? requestConvertible.asURLRequest() else {
            throw NetworkError.urlConstructionFailure
        }

        return dataTask(with: urlRequest, completionHandler: completionHandler)
    }
}

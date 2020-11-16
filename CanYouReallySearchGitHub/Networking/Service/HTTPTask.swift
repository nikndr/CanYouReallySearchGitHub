//
//  HTTPTask.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

typealias Parameters = [String: Any]
typealias NamedParameters = [ParameterNames: Any]
typealias HTTPHeaders = [HTTPHeader]

enum HTTPTask {
    case request
    case requestWithParameters(urlParameters: NamedParameters?)
}

extension NamedParameters {
    var parameters: Parameters {
        Parameters(uniqueKeysWithValues: map { key, value in (key.rawValue, value) })
    }
}

//
//  ParameterEncoder.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

typealias OptionalParameters = [ParameterNames: Any?]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

extension ParameterEncoder {
    static func coalesce(_ optionalParameters: OptionalParameters) -> NamedParameters {
        optionalParameters
            .filter { $0.value != nil }
            .mapValues { $0! }
    }
}

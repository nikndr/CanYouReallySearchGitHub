//
//  Endpoint.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 11.11.2020.
//

import Foundation

protocol EndPointType: URLRequestConvertible {
    var baseURL: URL? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var task: HTTPTask { get }
}

extension URLRequestConvertible where Self: EndPointType {
    var baseURL: URL? {
        URL(string: NetworkConstants.baseURL)
    }

    func asURLRequest() throws -> URLRequest {
        guard let baseURL = baseURL else {
            throw NetworkError.urlConstructionFailure
        }
        var request = URLRequest(url: baseURL.appendingPathComponent(path))

        request.httpMethod = method.rawValue
        request.setValue(HeaderTypes.githubJSON.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(HeaderTypes.applicationJSON.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        do {
            switch task {
            case .request:
                break
            case let .requestWithParameters(urlParameters):
                try configureParameters(urlParameters: urlParameters?.parameters, request: &request)
            }

            return request
        } catch {
            throw error
        }
    }

    private func configureParameters(urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
}

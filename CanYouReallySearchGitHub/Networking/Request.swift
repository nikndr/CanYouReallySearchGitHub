//
//  APIClient.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

typealias JSONValue = Any & Decodable

func request<ResponseType: Decodable>(route: EndPointType,
                                      decoder: JSONDecoder = JSONDecoder().withViewContext(),
                                      completion: @escaping (Result<ResponseType, NetworkError>) -> Void)
{
    do {
        let dataTask = try URLSession.shared.dataTask(with: route) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let response = try decoder.decode(ResponseType.self, from: data)
                completion(.success(response))
            } catch {
                debugPrint(error)
                completion(.failure(.serializationFailure))
            }
        }
        dataTask?.resume()
    } catch {
        completion(.failure(.urlConstructionFailure))
    }
}

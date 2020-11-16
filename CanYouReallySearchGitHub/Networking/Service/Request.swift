//
//  APIClient.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 12.11.2020.
//

import Foundation

typealias JSONValue = Any & Decodable

func request<ResponseType: Decodable>(route: EndPointType,
                                      decoder: JSONDecoder = JSONDecoder(),
                                      completion: @escaping (Result<ResponseType, NetworkError>) -> Void)
{
    do {
        let dataTask = try URLSession.shared.dataTask(with: route) { data, _, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            do {
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch let error {
                debugPrint(error)
                DispatchQueue.main.async {
                    completion(.failure(.serializationFailure))
                }
            }
        }
        dataTask?.resume()
    } catch {
        completion(.failure(.urlConstructionFailure))
    }
}

//
//  WebServicesNews.swift
//  NewsViperSWUI
//
//  Created by Jose Preatorian on 02-02-26.
//

import Foundation
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
}
protocol WebServicesNewsProtocol {
    func getArticles(completion: @escaping (Result<[Article], NetworkError>) -> Void)
}

class WebServicesNews: BaseService, WebServicesNewsProtocol {
    
    func getArticles(completion: @escaping (Result<[Article], NetworkError>) -> Void) {
        
        guard let endpointData = getEndpoint(fromName: "crearIssue") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: endpointData.url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(response.articles))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

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

        guard let endpointData = getEndpoint(fromName: "crearIssue"),
              let url = URL(string: endpointData.url.absoluteString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
           
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.serverError(error.localizedDescription)))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }

            do {
                let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.articles))
                }
            } catch {
                print("Error de decodificación: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
            
        }.resume()
    }
}

//
//  NewsInteractor.swift
//  NewsViperSWUI
//
//  Created by Jose Preatorian on 02-02-26.
//

import Foundation

protocol NewsInteractorInputProtocol {
    func fetchArticles()
}

protocol NewsInteractorOutputProtocol: AnyObject {
    func didFetchArticles(_ result: Result<[Article], NetworkError>)
}

class NewsInteractor: NewsInteractorInputProtocol {
    private let service: WebServicesNewsProtocol
    weak var presenter: NewsInteractorOutputProtocol?
    
    init(service: WebServicesNewsProtocol) {
        self.service = service
    }
    
    func fetchArticles() {
        service.getArticles { [weak self] result in
            // Pasamos el resultado completo (éxito o error) al presenter
            self?.presenter?.didFetchArticles(result)
        }
    }
}

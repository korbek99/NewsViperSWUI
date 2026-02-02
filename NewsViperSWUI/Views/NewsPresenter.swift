//
//  NewsPresenter.swift
//  NewsViperSWUI
//
//  Created by Jose Preatorian on 02-02-26.
//

import Foundation


class NewsPresenter: ObservableObject, NewsInteractorOutputProtocol {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var errorMessage: String?
    
    var interactor: NewsInteractorInputProtocol?

    var filteredArticles: [Article] {
        if searchText.isEmpty {
            return articles
        } else {
            return articles.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func getNews() {
        isLoading = true
        interactor?.fetchArticles()
    }

    func didFetchArticles(_ result: Result<[Article], NetworkError>) {
        DispatchQueue.main.async {
            self.isLoading = false
            switch result {
            case .success(let fetchedArticles):
                self.articles = fetchedArticles
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("Error: \(error)")
            }
        }
    }
}

//
//  PopularNewsView.swift
//  NewsViperSWUI
//
//  Created by Jose Preatorian on 02-02-26.
//
import SwiftUI

struct PopularNewsView: View {

    @ObservedObject var presenter: NewsPresenter
    
    var body: some View {
        NavigationStack {
            ZStack {
                if presenter.isLoading {
                    ProgressView("Buscando noticias...")
                } else if let errorMsg = presenter.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text(errorMsg)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button(action: {
                            presenter.getNews()
                        }) {
                            Label("Reintentar", systemImage: "arrow.clockwise")
                                .fontWeight(.bold)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List(presenter.filteredArticles) { article in

                        NavigationLink(destination: Text(article.title)) {
                            NewsRow(article: article)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                    }
                    .listStyle(.plain)
                    .refreshable {
                        presenter.getNews()
                    }
                }
            }
            .navigationTitle("News")

            .searchable(text: $presenter.searchText, prompt: "Buscar noticias...")
            .onAppear {
                if presenter.articles.isEmpty {
                    presenter.getNews()
                }
            }
        }
    }
}

struct NewsRow: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 220)
                            .frame(maxWidth: .infinity)
                            .clipped()
                    case .failure(_), .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 220)
                            .overlay(
                                Image(systemName: "newspaper")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding([.leading, .trailing], 10)
                
             
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack(alignment: .leading, spacing: 4) {
                    Text(article.source.name.uppercased())
                        .font(.caption2)
                        .fontWeight(.black)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                    
                    Text(article.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .padding(12)
            }
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    
            if let description = article.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .padding(.horizontal, 2)
            }

            Text(article.publishedAt.formatDate())
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(.horizontal, 2)
        }
    }
}

extension String {
    func formatDate() -> String {
        let inputFormatter = ISO8601DateFormatter()
        guard let date = inputFormatter.date(from: self) else { return self }
        
        let outputFormatter = RelativeDateTimeFormatter()
        outputFormatter.unitsStyle = .full
        outputFormatter.locale = Locale(identifier: "es_ES") 
        
        return outputFormatter.localizedString(for: date, relativeTo: Date())
    }
}
//#Preview {
//    PopularNewsView()
//}


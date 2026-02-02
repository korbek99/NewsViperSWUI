//
//  DetailsNewsView.swift
//  NewsViperSWUI
//
//  Created by Jose Preatorian on 02-02-26.
//


import SwiftUI

struct DetailsNewsView: View {
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
              
                NewsImage(url: article.urlToImage, height: 250)
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 16) {
                    
               
                    Text(article.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                    
         
                    HStack(alignment: .center, spacing: 8) {
                        Text(article.source.name)
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(4)
                        
                        Text("•")
                            .foregroundColor(.secondary)
                        
                        Text(article.publishedAt.formatDate())
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    if let author = article.author, !author.isEmpty {
                        Text("Por \(author)")
                            .font(.caption.italic())
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                  
                    Text("Resumen")
                        .font(.headline)
                    
                    Text(article.description ?? "Sin descripción disponible.")
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineSpacing(4)
                    
  
                    if let content = article.content {
                        Text("Contenido")
                            .font(.headline)
                            .padding(.top, 10)
                        
                        Text(cleanContent(content))
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(6)
                    }
 
                    if let url = URL(string: article.url) {
                        Link(destination: url) {
                            HStack {
                                Text("Leer noticia completa")
                                Image(systemName: "arrow.up.right.circle.fill")
                            }
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 5)
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .edgesIgnoringSafeArea(.top) 
        .navigationBarTitleDisplayMode(.inline)
    }
    

    private func cleanContent(_ content: String) -> String {
        return content.components(separatedBy: " [").first ?? content
    }
}


struct NewsImage: View {
    let url: String?
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: height)
                    .frame(maxWidth: .infinity)
                    .clipped()
            case .failure(_), .empty:
                ZStack {
                    Color.gray.opacity(0.1)
                    VStack {
                        Image(systemName: "newspaper")
                            .font(.largeTitle)
                            .foregroundColor(.gray.opacity(0.5))
                        Text("Imagen no disponible")
                            .font(.caption)
                            .foregroundColor(.gray.opacity(0.5))
                    }
                }
                .frame(height: height)
                .frame(maxWidth: .infinity)
            @unknown default:
                EmptyView()
            }
        }
    }
}

//#Preview {
//    DetailsNewsView()
//}

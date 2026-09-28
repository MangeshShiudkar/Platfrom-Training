//
//  ContentView.swift
//  SwiftUI_Assignment
//
//  Created by Mangesh Shiudkar on 25/09/26.
//

import SwiftUI

struct FeedView: View {
    @State private var articles: [Article]
    @State private var showCreatePage = false
    
    init(articles: [Article] = loadArticles()) {
        self.articles = articles
    }
    
    var body: some View {
        NavigationStack {
            List(articles) { article in
                NavigationLink(destination: ArticleDetailView(article: article)){
                    HStack(spacing: 10) {
                        Image(article.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        VStack(alignment: .leading) {
                            Text(article.title)
                                .font(.headline)
                            Text(article.content)
                                .font(.subheadline)
                                .lineLimit(3)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Feed")
            .overlay(alignment: .bottomTrailing) {
                Button {
                    showCreatePage = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                .padding()
            }
            .sheet(isPresented: $showCreatePage) {
                NavigationStack {
                    CreateArticleView(articles: $articles)
                }
            }
        }
    }
}

#Preview {
    let article = Article(
        id: UUID().uuidString,
        title: "Learn SwiftUI",
        image: "sample_article_image",
        content: "SwiftUI is Apple's innovative framework used to build user interfaces across all Apple platforms with the power of Swift. By adopting a declarative paradigm, it allows developers to state what the UI should do rather than writing procedural layout logic line by line. This means you can write less code, easily preview changes in real time, and maintain a single codebase for iOS, macOS, watchOS, and tvOS. With seamless integration into modern framework ecosystems and native support for dynamic type, dark mode, and accessibility, SwiftUI has quickly become the gold standard for modern Apple app development. Over the coming years, mastering its state management principles like State, Binding, and Environment will be critical for any developer looking to build cutting-edge applications."
    )
    FeedView(articles: [article])
}

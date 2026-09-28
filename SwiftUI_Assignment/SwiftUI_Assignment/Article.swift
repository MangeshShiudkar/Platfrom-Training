//
//  Article.swift
//  SwiftUI_Assignment
//
//  Created by Mangesh Shiudkar on 25/09/26.
//

import Foundation

struct Article: Identifiable, Codable {
    var id: String
    var title: String
    var image: String
    var content: String
}

func loadArticles() -> [Article] {
    guard let url = Bundle.main.url(forResource: "ArticleData", withExtension: "json") else {
        return []
    }
    guard let data = try? Data(contentsOf: url) else {
        return []
    }
    let articles = try? JSONDecoder().decode([Article].self, from: data)
    return articles ?? []
}

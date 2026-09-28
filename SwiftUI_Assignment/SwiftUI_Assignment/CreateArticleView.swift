//
//  CreateArticleView.swift
//  SwiftUI_Assignment
//
//  Created by Mangesh Shiudkar on 28/09/26.
//

import SwiftUI

struct CreateArticleView: View {
    @Binding var articles: [Article]
    @State private var title = ""
    @State private var content = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Post")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            TextField("Enter title", text: $title)
                .textFieldStyle(.roundedBorder)
                .modifier(FormFieldStyleModifier())
            TextEditor(text: $content)
                .frame(height: 400)
                .modifier(FormFieldStyleModifier())
            Button("Create Post") {
                let article = Article(id: UUID().uuidString, title: title, image: "sample_article_image", content: content)
                articles.insert(article, at: 0)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(30)
    }
}


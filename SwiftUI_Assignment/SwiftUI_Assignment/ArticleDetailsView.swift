//
//  ArticleDetailsView.swift
//  SwiftUI_Assignment
//
//  Created by Mangesh Shiudkar on 28/09/26.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Image(article.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width:200,height: 200)
                    .frame(maxWidth: .infinity)
                Text(article.content)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//
//  CustomViewModifier.swift
//  SwiftUI_Assignment
//
//  Created by Mangesh Shiudkar on 28/09/26.
//


import SwiftUI

struct FormFieldStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 1.5)
            )
    }
}

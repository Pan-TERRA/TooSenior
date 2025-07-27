//
//  ButtonViewModifiers.swift
//  TooSenior
//
//  Created by Vladyslav Krut on 25.07.2025.
//

import SwiftUI

struct TooAccentButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}

struct TooSecondaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
            .foregroundColor(.primary)
            .cornerRadius(12)
    }
}

extension View {
    func tooAccentButtonStyle() -> some View {
        modifier(TooAccentButtonStyle())
    }

    func tooSecondaryButtonStyle() -> some View {
        modifier(TooSecondaryButtonStyle())
    }
}

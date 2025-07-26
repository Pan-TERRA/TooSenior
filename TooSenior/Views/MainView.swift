//
//  MainView.swift
//  TooSenior
//
//  Created by Vladyslav Krut on 3/5/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)

                Text("Welcome to TooSenior!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text("There is nothing here yet.")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)

                Spacer()
            }
            .padding()
            .navigationTitle("Main page... maybe?")
        }
    }
}

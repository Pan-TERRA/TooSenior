//
//  ForgotPasswordView.swift
//  TooSenior
//
//  Created by Vladyslav Krut on 3/5/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer(minLength: 60)
            
            VStack(spacing: 16) {
                Text("Forgot Password")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Enter your email address and we'll send you a link to reset your password")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            TextField("Enter your email", text: $viewModel.email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            Button("Send Reset Link") {
                // Mock functionality
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarTitleDisplayMode(.inline)
    }
}
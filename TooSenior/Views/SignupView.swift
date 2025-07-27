//
//  SignupView.swift
//  TooSenior
//
//  Created by Vladyslav Krut on 3/5/25.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 40)
                screenHeader()
                Spacer(minLength: 32)
                inputFieldsSection()
                Spacer(minLength: 16)
                signUpButton()
                Spacer(minLength: 16)
                loginButton()
                Spacer(minLength: 32)
                socialMediaLoginSection()
                Spacer(minLength: 40)
            }
            .disabled(viewModel.isLoading)
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
    }

    @ViewBuilder
    private func screenHeader() -> some View {
        VStack(spacing: 16) {
            Text("TooSenior")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Create your account to get started with TooSenior and access all features")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
        }
    }

    @ViewBuilder
    private func delimitingText(text: String) -> some View {
        HStack {
            Rectangle()
                .fill(Color(.separator))
                .frame(height: 1)

            Text(text)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.horizontal, 8)
                .opacity(0.3)

            Rectangle()
                .fill(Color(.separator))
                .frame(height: 1)
        }
    }

    @ViewBuilder
    private func inputFieldsSection() -> some View {
        VStack(spacing: 16) {
            // Name Field
            TextField("Enter your full name", text: $viewModel.name)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .autocapitalization(.words)

            // Email Field
            TextField("Enter your email", text: $viewModel.email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            // Password Field
            VStack {
                HStack {
                    SecureField("Enter password", text: $viewModel.password)

                    Button(action: {}, label: {
                        Image(systemName: "eye")
                            .foregroundColor(.gray)
                    })
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }

            // Error Message
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
            }
        }
    }

    @ViewBuilder
    private func signUpButton() -> some View {
        Button(action: {
            viewModel.signup()
        }, label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                }
                Text("Sign Up")
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(12)
        })
        .disabled(viewModel.isLoading)
    }

    @ViewBuilder
    private func loginButton() -> some View {
        Button(action: {
            viewModel.clearForm()
            dismiss()
        }, label: {
            HStack(spacing: 0) {
                Text("Already have an account?")
                    .foregroundColor(.primary)
                Text(" Sign in instead!")
                    .foregroundColor(.blue)
            }
            .font(.footnote)
        })
        .buttonStyle(PlainButtonStyle())
    }

    @ViewBuilder
    private func socialMediaLoginSection() -> some View {
        VStack(spacing: 16) {
            delimitingText(text: "Continue with social media")

            // Social Login Buttons
            HStack {
                Button("Apple") {
                    viewModel.socialLogin()
                }
                .tooSecondaryButtonStyle()

                Button("Google") {
                    viewModel.socialLogin()
                }
                .tooSecondaryButtonStyle()

                Button("Facebook") {
                    viewModel.socialLogin()
                }
                .tooSecondaryButtonStyle()
            }
            .disabled(viewModel.isLoading)
        }
    }
}

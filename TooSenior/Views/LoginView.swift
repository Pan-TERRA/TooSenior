//
//  LoginView.swift
//  TooSenior
//
//  Created by Vladyslav Krut on 3/5/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 40)
                screenHeader()
                Spacer(minLength: 32)
                inputFieldsSection()
                signInButton()
                Spacer(minLength: 16)
                signUpButton()
                Spacer(minLength: 32)
                socialMediaLoginSection()
                Spacer(minLength: 24)
                delimitingText(text: "or")
                
                Button(action: {
                    viewModel.guestLogin()
                }) {
                    Text("Continue as a Guest")
                }
                .tooSecondaryButtonStyle()
                .padding(.bottom, 40)
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
            
            Text("This is a user-friendly login interface where you can access your account easily")
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
        VStack {
            TextField("Enter your email", text: $viewModel.email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            Spacer(minLength: 16)

            VStack {
                HStack {
                    SecureField("Enter password", text: $viewModel.password)
                    
                    Button(action: {}) {
                        Image(systemName: "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                NavigationLink("Forgot password?", value: AuthRoute.forgotPassword)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom)
                    .font(.footnote)
                    .foregroundColor(.accentColor)
            }
        }
    }
    
    @ViewBuilder
    private func signInButton() -> some View {
        Button(action: {
            viewModel.login()
        }) {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                }
                Text("Sign In")
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .disabled(viewModel.isLoading)
    }
    
    @ViewBuilder
    private func signUpButton() -> some View {
        NavigationLink(value: AuthRoute.signup) {
            HStack(spacing: 0) {
                Text("Don't have an account yet?")
                    .foregroundColor(.primary)
                Text(" Sign up now!")
                    .foregroundColor(.blue)
            }
            .font(.footnote)
        }
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

#Preview {
    NavigationStack {
        LoginView(viewModel: AuthenticationViewModel())
    }
}

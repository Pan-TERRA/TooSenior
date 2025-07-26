//
//  AuthenticationViewModel.swift
//  TooSenior
//
//  Created by Vladyslav Krut on 3/5/25.
//

import Foundation
import Combine

@MainActor
final class AuthenticationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoggedIn: Bool = false

    var isLoginFormValid: Bool {
        !email.isEmpty && !password.isEmpty && isValidEmail(email)
    }

    var isSignupFormValid: Bool {
        !name.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        isValidEmail(email) &&
        password.count >= 6
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    func login() {
        guard isLoginFormValid else {
            errorMessage = "Please fill in all fields with valid information"
            return
        }

        isLoading = true
        errorMessage = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            self.isLoggedIn = true
        }
    }

    func guestLogin() {
        self.isLoggedIn = true
    }

    func signup() {
        guard isSignupFormValid else {
            if password.count < 6 {
                errorMessage = "Password must be at least 6 characters"
            } else {
                errorMessage = "Please fill in all fields with valid information"
            }
            return
        }

        isLoading = true
        errorMessage = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            self.isLoggedIn = true
        }
    }

    func socialLogin() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            self.isLoggedIn = true
        }
    }

    func forgotPassword() {
        print("Forgot password tapped")
    }

    func clearForm() {
        email = ""
        password = ""
        name = ""
        errorMessage = ""
    }
}

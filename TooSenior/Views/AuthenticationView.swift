//
//  AuthenticationView.swift
//  TooSenior
//
//  Created by Vladyslav Krut on 3/5/25.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        if viewModel.isLoggedIn {
            MainView()
        } else {
            NavigationStack(path: $navigationPath) {
                LoginView(viewModel: viewModel)
                    .navigationDestination(for: AuthRoute.self) { route in
                        switch route {
                        case .signup:
                            SignupView(viewModel: viewModel)
                        case .forgotPassword:
                            ForgotPasswordView(viewModel: viewModel)
                        }
                    }
            }
        }
    }
}

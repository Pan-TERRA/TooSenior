//
//  AuthenticationView.swift
//  TooSenior
//
//  Created by Vladyslav Krut on 3/5/25.
//

import SwiftUI

public struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var navigationPath = NavigationPath()
    
    public init() {}

    public var body: some View {
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

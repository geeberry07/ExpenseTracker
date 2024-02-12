//
//  UserCredentialsView.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//

import SwiftUI
import Foundation
import Combine

	//MARK: USER CREDENTIAL/LOGIN MODEL

struct UserCredentials {
	var email: String = ""
	var password: String = ""
}

	//MARK: USER CREDENTILS VIEW MODEL

class UserCredentialsViewModel: ObservableObject {
	@Published var credentials = UserCredentials()

	func login() {
			// Implement login logic here
		print("Login with: \(credentials.email)")
	}

	var isFormValid: Bool {
			// Example validation logic
		return !credentials.email.isEmpty && !credentials.password.isEmpty
	}
}

	//MARK: USER CREDENTIAL VIEW

struct UserCredentialsView: View {
	@StateObject var viewModel = UserCredentialsViewModel()

	var body: some View {
		NavigationView {
			Form {
				Section(header: Text("Login")) {
					TextField("Email", text: $viewModel.credentials.email)
						.keyboardType(.emailAddress)
						.autocapitalization(.none)
					SecureField("Password", text: $viewModel.credentials.password)
				}

				Button("Login") {
					viewModel.login()
				}
				.disabled(!viewModel.isFormValid)
			}
			.navigationBarTitle("Login")
		}
	}
}

struct UserCredentialsView_Previews: PreviewProvider {
	static var previews: some View {
		UserCredentialsView()
	}
}

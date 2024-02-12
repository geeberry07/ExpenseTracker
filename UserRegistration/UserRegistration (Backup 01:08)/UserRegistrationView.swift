//
//  UserCredntialsView.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//
import SwiftUI
import Foundation
import Combine

	//MARK: USER REGISTRATION/SIGNUP MODEL

struct UserRegistrationModel {
	var firstName: String = ""
	var lastName: String = ""
	var email: String = ""
	var password: String = ""
	var confirmPassword: String = ""

}

	//MARK: USER REGISTRATION VIEW MODEL

class UserRegistrationViewModel: ObservableObject {
	@Published var user = UserRegistrationModel()

		// Add any additional methods for validation, registration logic, etc.
	func register() {
			// Implement registration logic here
		print("User Registered: \(user)")
	}

		// Example validation logic
	var isFormValid: Bool {
			// Simple validation example
		return !user.firstName.isEmpty && !user.lastName.isEmpty && user.password == user.confirmPassword
	}
}

//MARK: USER REGISTRATION VIEW

struct UserRegistrationView: View {
	@StateObject var viewModel = UserRegistrationViewModel()

	var body: some View {
		NavigationView {
			Form {
				Section(header: Text("Personal Information")) {
					TextField("First Name", text: $viewModel.user.firstName)
					TextField("Last Name", text: $viewModel.user.lastName)
				}

				Section(header: Text("Account Information")) {
					TextField("Email", text: $viewModel.user.email)
						.keyboardType(.emailAddress)
						.autocapitalization(.none)
					SecureField("Password", text: $viewModel.user.password)
					SecureField("Confirm Password", text: $viewModel.user.confirmPassword)
				}

				Button("Register") {
					viewModel.register()
				}
				.disabled(!viewModel.isFormValid)
			}
			.navigationBarTitle("Sign Up")
		}
	}
}

struct UserRegistrationView_Previews: PreviewProvider {
	static var previews: some View {
		UserRegistrationView()
	}
}

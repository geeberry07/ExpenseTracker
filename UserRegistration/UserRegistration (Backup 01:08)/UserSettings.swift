//
//  UserSettings.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//

import SwiftUI
import Foundation
import Combine

	//MARK: USER SETTINGS MODEL

struct UserSettingsModel {
	var notificationsEnabled: Bool = true
	var darkModeEnabled: Bool = false
	var volumeLevel: Double = 0.5
		// Add other settings as needed
}

	//MARK: USER SETTINGS VIEW MODEL

class UserSettingsViewModel: ObservableObject {
	@Published var settings = UserSettingsModel()

	func saveSettings() {
			// Implement the logic to save the settings
		print("Settings saved: \(settings)")
	}

		// Add any additional methods for handling specific settings
}

	//MARK: USER SETTINGS VIEW

struct UserSettingsView: View {
	@StateObject var viewModel = UserSettingsViewModel()

	var body: some View {
		NavigationView {
			Form {
				Toggle("Enable Notifications", isOn: $viewModel.settings.notificationsEnabled)
				Toggle("Dark Mode", isOn: $viewModel.settings.darkModeEnabled)
				Slider(value: $viewModel.settings.volumeLevel, in: 0...1, step: 0.1)
					.accessibilityValue(Text("Volume level: \(Int(viewModel.settings.volumeLevel * 100))%"))

				Button("Save Settings") {
					viewModel.saveSettings()
				}
			}
			.navigationBarTitle("Settings")
		}
	}
}

struct UserSettingsView_Previews: PreviewProvider {
	static var previews: some View {
		UserSettingsView()
	}
}



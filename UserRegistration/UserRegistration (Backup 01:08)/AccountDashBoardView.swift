//
//  AccountDashBoardView.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//

import SwiftUI
import Foundation
import Combine

	//MARK: USER ACCOUNTS MODEL - DASHBOARD

struct AccountModel: Identifiable {
	var id: String = UUID().uuidString
	var name: String
	var balance: Double
		// Add other relevant properties
}

	//MARK: USER ACCOUNTS VIEW MODEL MODEL - DASHBOARD

class AccountsViewModel: ObservableObject {
	@Published var accounts: [AccountModel] = []

	init() {
		loadAccounts() // Load accounts from a data source
					   // Initialize with dummy data or load from storage
	}

		// Implement the logic to load accounts from a data source
	func loadAccounts() {
			// Add logic to load accounts here
	}

	func addAccount(name: String, balance: Double) {
		let newAccount = AccountModel(name: name, balance: balance)
		accounts.append(newAccount)
	}

	func deleteAccount(at offsets: IndexSet) {
		accounts.remove(atOffsets: offsets)
	}

	func editAccount(id: String, newName: String, newBalance: Double) {
		if let index = accounts.firstIndex(where: { $0.id == id }) {
			accounts[index].name = newName
			accounts[index].balance = newBalance
		}
	}

	func updateAccountBalance(accountId: String, change: Double) {
		if let index = accounts.firstIndex(where: { $0.id == accountId }) {
			accounts[index].balance += change
		}
	}
}

	//MARK: USER ACCOUNTS VIEW - DASHBOARD

struct AccountsDashboardView: View {
	@StateObject var viewModel = AccountsViewModel()
	@State private var isAddingAccount = false // Add this line

	var body: some View {
		NavigationView {
			List {
				ForEach(viewModel.accounts) { account in
					NavigationLink(destination: TransactionsView(viewModel: TransactionsViewModel(accountId: account.id, accountsViewModel: viewModel))) {
						HStack {
							Text(account.name)
							Spacer()
							Text("$\(account.balance, specifier: "%.2f")")
								.foregroundColor(account.balance >= 0 ? .green : .red)
						}
					}
				}
				.onDelete(perform: deleteAccount)
			}
			.navigationBarTitle("Accounts")
			.navigationBarItems(leading: EditButton(), trailing: addButton)
			.sheet(isPresented: $isAddingAccount) {
				AddAccountView(isPresented: self.$isAddingAccount, viewModel: self.viewModel)
			}
		}
	}

	private var addButton: some View {
		Button(action: { self.isAddingAccount = true }) {
			Image(systemName: "plus")
		}
	}

	private func deleteAccount(at offsets: IndexSet) {
		viewModel.accounts.remove(atOffsets: offsets)
	}
}

	//MARK: ADD ACCOUNT VIEW

struct AddAccountView: View {
	@Binding var isPresented: Bool
	@ObservedObject var viewModel: AccountsViewModel
	@State private var name: String = ""
	@State private var balance: Double = 0

	var body: some View {
		NavigationView {
			Form {
				TextField("Account Name", text: $name)
				TextField("Initial Balance", value: $balance, formatter: NumberFormatter())

				Button("Add Account") {
					viewModel.addAccount(name: name, balance: balance)
					isPresented = false
				}
				.disabled(name.isEmpty)
			}
			.navigationBarTitle("Add Account")
			.navigationBarItems(leading: Button("Cancel") {
				isPresented = false
			})
		}
	}
}

	//MARK: ACCOUNT ROW VIEW

struct AccountRowView: View {
	var accountName: String
	var accountDescription: String
	var balance: Double

	var body: some View {
		HStack {
				// Circle with Gradient and Question Mark
			Circle()
				.fill(LinearGradient(
					gradient: Gradient(colors: [.blue, .purple]),
					startPoint: .topLeading,
					endPoint: .bottomTrailing))
				.frame(width: 50, height: 50)
				.overlay(Text("?").foregroundColor(.white))

				// Account Name and Description
			VStack(alignment: .leading) {
				Text(accountName).font(.headline)
				Text(accountDescription).font(.subheadline)
			}

			Spacer()

				// Balance aligned to the right
			Text("Balance: \(balance, specifier: "%.2f")")
				.font(.footnote)
				.frame(alignment: .trailing)
		}
		.padding()
	}
}


struct AccountsDashboardView_Previews: PreviewProvider {
	static var previews: some View {
		AccountsDashboardView()
	}
}



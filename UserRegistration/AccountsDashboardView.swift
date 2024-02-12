//
//  AccountsViewModel.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//
import Foundation
import Combine

struct AccountsDashboardView: View {
	@StateObject var viewModel = AccountsViewModel()
	@State private var isAddingAccount = false

	var body: some View {
		NavigationView {
			List {
				ForEach(viewModel.accounts) { account in
					NavigationLink(destination: TransactionsView(viewModel: TransactionsViewModel(accountId: account.id, accounts: [account]))) {
						HStack {
							Text(account.name)
							Spacer()
							Text("$\(account.balance, specifier: "%.2f")")
								.foregroundColor(account.balance >= 0 ? .green : .red)
						}
					}
				}
				.onDelete(perform: viewModel.deleteAccount)
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
}

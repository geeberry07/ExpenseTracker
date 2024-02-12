//
//  TransactionsDashboardView.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//

import SwiftUI

//MARK: TRANSACTION ROW
	// Implement a view for each transaction row, which could include an edit button
struct TransactionRow: View {
	var transaction: TransactionModel
	@ObservedObject var viewModel: TransactionsViewModel

	var body: some View {
			// Layout for each transaction. Include an edit button if needed
		Text(transaction.description)
	}
}
	//MARK: USER TRANSACTIONS MODEL - DASHBOARD

struct TransactionModel: Identifiable {
	var id: String = UUID().uuidString
	var accountId: String
	var amount: Double
	var date: Date
	var description: String
	var category: String // New field for categorizing the transaction

		// Add other relevant properties (e.g., category, type)
}

	//MARK: USER TRANSACTIONS VIEW MODEL - DASHBOARD

class TransactionsViewModel: ObservableObject {
	@Published var transactions: [TransactionModel] = []
	var accountId: String
	var accountsViewModel: AccountsViewModel

	init(accountId: String, accountsViewModel: AccountsViewModel) {
		self.accountId = accountId
		self.accountsViewModel = accountsViewModel
		loadTransactions()
	}

	func loadTransactions() {
			// Load transactions for the specified account
			// Add logic to load transactions here\

	}

	func addTransaction(amount: Double, description: String, category: String) {
			// Convert the amount to a negative value if it's positive
		let transactionAmount = amount > 0 ? -amount : amount

		let newTransaction = TransactionModel(accountId: accountId, amount: transactionAmount, date: Date(), description: description, category: category)
		transactions.append(newTransaction)
		accountsViewModel.updateAccountBalance(accountId: accountId, change: transactionAmount)
			// ... update budget if necessary ...
	}
	func deleteTransaction(withId id: String) {
		guard let index = transactions.firstIndex(where: { $0.id == id }) else { return }
		let transaction = transactions[index]
		transactions.remove(at: index)
		accountsViewModel.updateAccountBalance(accountId: transaction.accountId, change: -transaction.amount)
	}

	func editTransaction(_ updatedTransaction: TransactionModel) {
		guard let oldIndex = transactions.firstIndex(where: { $0.id == updatedTransaction.id }) else { return }
		let oldTransaction = transactions[oldIndex]

		let balanceChange = updatedTransaction.amount - oldTransaction.amount
		transactions[oldIndex] = updatedTransaction
		accountsViewModel.updateAccountBalance(accountId: updatedTransaction.accountId, change: balanceChange)
	}

	private func updateAccountBalance(accountId: String, change: Double) {
		accountsViewModel.updateAccountBalance(accountId: accountId, change: change)
	}
}

struct TransactionsView: View {
	@ObservedObject var viewModel: TransactionsViewModel
	@State private var isAddingTransaction = false

	var body: some View {
		NavigationView {
			List {
				ForEach(viewModel.transactions) { transaction in
					TransactionRow(transaction: transaction, viewModel: viewModel)
				}
				.onDelete(perform: deleteTransactions)
			}
			.navigationBarTitle("Transactions")
			.navigationBarItems(trailing: Button(action: {
				isAddingTransaction = true
			}) {
				Image(systemName: "plus")
			})

			.sheet(isPresented: $isAddingTransaction) {
					// This is where you use AddTransactionView
				AddTransactionView(isPresented: $isAddingTransaction, viewModel: viewModel)
			}

			AddTransactionView(isPresented: $isAddingTransaction, viewModel: viewModel)
		}
			//'loadTransactions' is inaccessible due to 'private' protection level
		.onAppear {
			viewModel.loadTransactions() // Reload transactions when the view appears
		}
	}
	private func deleteTransactions(at offsets: IndexSet) {
		offsets.forEach { index in
			let transactionId = viewModel.transactions[index].id
			viewModel.deleteTransaction(withId: transactionId)
		}
	}
}

//MARK: ADD TRANSACTION VIEW

struct AddTransactionView: View {
	@Binding var isPresented: Bool
	@ObservedObject var viewModel: TransactionsViewModel
	@State private var amount: Double = 0
	@State private var description: String = ""
	@State private var category: String = ""

	var body: some View {
		NavigationView {
			Form {
				TextField("Description", text: $description) // Correct usage
				TextField("Amount", value: $amount, formatter: NumberFormatter()) // Correct usage for Double
				TextField("Category", text: $category) // Correct usage
				Button("Add Transaction") {
					viewModel.addTransaction(amount: amount, description: description, category: category)
					isPresented = false
				}
			}
			.navigationBarTitle("Add Transaction")
			.navigationBarItems(leading: Button("Cancel") {
				isPresented = false
			})
		}
	}
}

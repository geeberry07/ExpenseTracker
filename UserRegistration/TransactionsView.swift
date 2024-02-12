//
//  TransactionsView.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//

import SwiftUI

struct TransactionsView: View {
	@ObservedObject var viewModel: TransactionsViewModel
	@State private var showingAddTransactionView = false

	var body: some View {
		NavigationView {
			List(viewModel.transactions) { transaction in
					// Display each transaction
			}
			.navigationBarTitle("Transactions")
			.navigationBarItems(trailing: Button(action: {
				showingAddTransactionView = true
			}) {
				Image(systemName: "plus")
			})
			.sheet(isPresented: $showingAddTransactionView) {
					// Your view for adding a new transaction
				AddTransactionView(isPresented: $showingAddTransactionView, viewModel: viewModel)
			}
		}
	}
}

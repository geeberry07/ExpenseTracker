//
//  AddTransactionsView.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//

import SwiftUI

struct AddTransactionView: View {
	@Binding var isPresented: Bool
	@ObservedObject var viewModel: TransactionsViewModel
	@State private var amount: Double = 0
	@State private var description: String = ""
	@State private var category: String = ""

	var body: some View {
		NavigationView {
			Form {
				TextField("Description", text: $description)
				TextField("Amount", value: $amount, formatter: NumberFormatter())
				TextField("Category", text: $category)
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

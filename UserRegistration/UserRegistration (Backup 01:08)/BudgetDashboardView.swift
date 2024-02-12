//
//  BudgetDashboardView.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//

import SwiftUI
import Foundation
import Combine

	//MARK: USER BUDGET MODEL - DASHBOARD

struct BudgetModel: Identifiable {
	var id = UUID()
	var category: String
	var allocatedAmount: Double
	var spentAmount: Double = 0
}

	//MARK: BUDGET VIEW MODEL

class BudgetViewModel: ObservableObject {
	@Published var budgets: [BudgetModel] = []
	@Published var transactions: [TransactionModel] = []

	init() {
			// Initialize with default budgets or load from storage
			// Example: budgets.append(Budget(category: "Groceries", allocatedAmount: 500))
	}

		// Call this method when new transactions are added or existing ones are modified
	func updateBudgets() {
			// Reset spent amount
		budgets = budgets.map { var budget = $0; budget.spentAmount = 0; return budget }

			// Calculate spent amounts
		for transaction in transactions {
			if let index = budgets.firstIndex(where: { $0.category == transaction.category }) {
				budgets[index].spentAmount += transaction.amount
			}
		}
	}
}

	//MARK: BUDGET VIEW - DASHBOARD

struct BudgetDashboardView: View {
	@StateObject var viewModel = BudgetViewModel()

	var body: some View {
		NavigationView {
			List(viewModel.budgets) { budget in
				VStack(alignment: .leading) {
					Text(budget.category)
					HStack {
						Text("Allocated: \(budget.allocatedAmount, specifier: "%.2f")")
						Spacer()
						Text("Spent: \(budget.spentAmount, specifier: "%.2f")")
							.foregroundColor(budget.spentAmount > budget.allocatedAmount ? .red : .green)
					}
				}
			}
			.navigationBarTitle("Budgets")
		}
	}
}


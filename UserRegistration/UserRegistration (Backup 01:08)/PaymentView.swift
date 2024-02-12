//
//  PaymentView.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//

import SwiftUI

	//MARK: USER PAYMENT MODEL

struct Payment {
	var id: String
	var amount: Double
	var date: Date
	var payee: String
	var category: String
}

	//MARK: USER PAYMENT VIEW MODEL

class PaymentViewModel: ObservableObject {
	@Published var payments: [Payment] = []

		// Add more functions as needed, e.g., to fetch or add payments
	func addPayment(_ payment: Payment) {
		payments.append(payment)
	}

		// Example function to load dummy data
	func loadDummyData() {
		payments = [
			Payment(id: "1", amount: 50.0, date: Date(), payee: "Alice", category: "Groceries"),
			Payment(id: "2", amount: 75.0, date: Date(), payee: "Bob", category: "Utilities")
		]
	}
}

	//MARK: PAYMENT VIEW

struct PaymentView: View {
	@ObservedObject var viewModel = PaymentViewModel()

	var body: some View {
		List(viewModel.payments, id: \.id) { payment in
			VStack(alignment: .leading) {
				Text(payment.payee).font(.headline)
				Text(payment.category).font(.subheadline)
				Text("Amount: \(payment.amount, specifier: "%.2f")").font(.footnote)
				Text("Date: \(payment.date, style: .date)").font(.footnote)
			}
		}
		.onAppear {
			viewModel.loadDummyData() // Load data when the view appears
		}
	}
}

	//MARK: PAYMENT ROW VIEW

struct PaymentRowView: View {
	var payment: Payment

	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(payment.payee).font(.headline)
				Text(payment.category).font(.subheadline)
			}

			Spacer()

			VStack(alignment: .trailing) {
				Text("Amount: \(payment.amount, specifier: "%.2f")").font(.footnote)
				Text("Date: \(payment.date, style: .date)").font(.footnote)
			}
		}
		.padding()
	}
}

struct PaymentView_Previews: PreviewProvider {
	static var previews: some View {
		PaymentView()
	}
}

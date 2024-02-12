//
//  ContentView.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/7/24.
//

//MARK: USER REGISTRATION MODEL & VIEW MODEL

import Foundation
//MARK: USER REGISTRATION VIEW MODEL

import Combine
//MARK: USER REGISTRATION VIEW

import SwiftUI



//MARK: TRANSACATON ROW VIEW

struct TransactionRowView: View {
	var transactionName: String
	var transactionDescription: String
	var amount: Double

	var body: some View {
		HStack {
				// Icon with Gradient
			Circle()
				.fill(LinearGradient(
					gradient: Gradient(colors: [.green, .yellow]),
					startPoint: .topLeading,
					endPoint: .bottomTrailing))
				.frame(width: 50, height: 50)
				.overlay(Text("$").foregroundColor(.white))

				// Transaction Details
			VStack(alignment: .leading) {
				Text(transactionName).font(.headline)
				Text(transactionDescription).font(.subheadline)
			}

			Spacer()

				// Amount
			Text("\(amount, specifier: "%.2f")")
				.font(.footnote)
				.frame(alignment: .trailing)
		}
		.padding()
	}
}

struct TransactionRowView_Previews: PreviewProvider {
	static var previews: some View {
		TransactionRowView(transactionName: "Groceries", transactionDescription: "Weekly shopping", amount: -86.75)
	}
}





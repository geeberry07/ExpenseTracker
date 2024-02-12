//
//  CategoryView.swift
//  UserRegistration
//
//  Created by Gary Robert Ellis on 1/8/24.
//

import SwiftUI
import Foundation
import Combine

	//MARK: CATEGORY MODEL
struct Category: Identifiable {
	var id = UUID()
	var name: String
	var systemImageName: String
}

	//MARK: CATEGORY VIEW MODEL

class CategoriesViewModel: ObservableObject {
	@Published var categories: [Category] = []

	init() {
		loadCategories()
	}

	private func loadCategories() {
		categories = [
			Category(name: "Housing", systemImageName: "house"),
			Category(name: "Utilities", systemImageName: "wrench.and.screwdriver"),
			Category(name: "Transportation", systemImageName: "car"),
			Category(name: "Groceries", systemImageName: "cart"),
			Category(name: "Dining out", systemImageName: "fork.knife"),
			Category(name: "Entertainment", systemImageName: "film"),
			Category(name: "Health and Fitness", systemImageName: "heart.text.square"),
			Category(name: "Insurance", systemImageName: "shield"),
			Category(name: "Debt Payments", systemImageName: "dollarsign.circle"),
			Category(name: "Savings", systemImageName: "banknote"),
			Category(name: "Gifts and Donations", systemImageName: "gift"),
			Category(name: "Education", systemImageName: "book.closed"),
			Category(name: "Personal Care", systemImageName: "figure.wave"),
			Category(name: "Travel", systemImageName: "airplane"),
			Category(name: "Miscellaneous", systemImageName: "tag")
		]
	}
}

	//MARK: CATEGORY VIEW

struct CategoryView: View {
	let category: Category

	var body: some View {
		HStack {
			Image(systemName: category.systemImageName)
				.foregroundColor(.blue)
			Text(category.name)
		}
	}
}

	//MARK: CATEGORY ROW VIEW

struct CategoryRowView: View {
	var categoryName: String

	var body: some View {
		HStack {
				// Icon with Gradient
			Circle()
				.fill(LinearGradient(
					gradient: Gradient(colors: [.red, .orange]),
					startPoint: .topLeading,
					endPoint: .bottomTrailing))
				.frame(width: 50, height: 50)
				.overlay(Text("?").foregroundColor(.white))

				// Category Name
			Text(categoryName).font(.headline)

			Spacer()
		}
		.padding()
	}
}


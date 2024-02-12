import SwiftUI

struct DashboardView: View {
	var body: some View {
		NavigationView {
			VStack {
				Text("Welcome to the Dashboard")
					.font(.headline)
					.padding()

				NavigationLink(destination: AccountsDashboardView()) {
					Text("View Accounts")
						.padding()
						.frame(maxWidth: .infinity)
						.background(Color.blue)
						.foregroundColor(.white)
						.cornerRadius(8)
						.padding(.horizontal)
				}

				NavigationLink(destination: BudgetDashboardView()) {
					Text("View Budget")
						.padding()
						.frame(maxWidth: .infinity)
						.background(Color.green)
						.foregroundColor(.white)
						.cornerRadius(8)
						.padding(.horizontal)
				}

					// Add more navigation options as needed
			}
			.navigationBarTitle("Dashboard", displayMode: .inline)
		}
	}
}

struct DashboardView_Previews: PreviewProvider {
	static var previews: some View {
		DashboardView()
	}
}

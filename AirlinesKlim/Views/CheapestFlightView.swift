import SwiftUI

struct CheapestFlightsView: View {
    @ObservedObject var viewModel: FlightViewModel
    var isFlightsVisible: Bool
    
    var body: some View {
        VStack {
            Text("Cheapest Flights")
                .font(.headline)
                .padding(.top, 8)
                .opacity(isFlightsVisible ? 1 : 0)
                .animation(.easeIn(duration: 0.5).delay(0.3), value: isFlightsVisible)
            
            VStack {
                ForEach(viewModel.cheapestFlights) { flight in
                    NavigationLink(destination: FlightDetailView(flight: flight)) {
                        VStack {
                            Text(flight.airline)
                                .font(.subheadline)
                                .bold()
                            Text(flight.departure_at.prefix(10))
                                .font(.caption)
                            Text("\(flight.price) RUB")
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .shadow(radius: 3)
                        .padding(.bottom, 8)
                        .scaleEffect(isFlightsVisible ? 1 : 0.9)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isFlightsVisible)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

import SwiftUI

struct FlightListView: View {
    @ObservedObject var viewModel: FlightViewModel
    var geometry: GeometryProxy
    
    var body: some View {
        List(viewModel.flights) { flight in
            VStack(alignment: .leading) {
                Text("Airline: \(flight.airline)")
                Text("Flight Number: \(flight.flight_number)")
                Text("Departure: \(flight.departure_at)")
                if let returnDate = flight.return_at {
                    Text("Return: \(returnDate)")
                }
                Text("Price: \(flight.price) RUB")
            }
            .transition(.slide)
        }
        .frame(height: viewModel.flights.isEmpty ? 0 : geometry.size.height * 0.3)
    }
}

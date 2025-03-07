
import SwiftUI

struct FlightDetailView: View {
    var flight: Flight
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Airline: \(flight.airline)")
                .font(.headline)
            
            Text("Flight Number: \(flight.flight_number)")
            
            Text("Departure: \(flight.departure_at)")
            
            if let returnDate = flight.return_at {
                Text("Return: \(returnDate)")
            }
            
            Text("Price: \(flight.price) RUB")
                .font(.title)
                .foregroundColor(.green)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Flight Details")
    }
}

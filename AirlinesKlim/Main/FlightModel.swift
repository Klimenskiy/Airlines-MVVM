

import Foundation



struct FlightResponse: Codable {
    let data: [String: [String: Flight]]
    let success: Bool
}

struct Flight: Codable, Identifiable {
    let id = UUID()
    let airline: String
    let departure_at: String
    let return_at: String?
    let price: Int
    let flight_number: Int
}

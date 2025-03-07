import Foundation
import Combine

class FlightService {
    private let apiKey = "93a8a3aead783109fc2d5f70ed594089"
    
    func fetchFlights(origin: String, destination: String, departDate: String, returnDate: String) -> AnyPublisher<[Flight], Error> {
        var urlString = "https://api.travelpayouts.com/v1/prices/direct?origin=\(origin)&destination=\(destination)&depart_date=\(departDate)&return_date=\(returnDate)&token=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // паблишер вернуть
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                // ошибка при неверном коде
                guard let httpResponse = result.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
                }
                return result.data
            }
            .decode(type: FlightResponse.self, decoder: JSONDecoder())
            .tryMap { flightResponse -> [Flight] in
               
                guard flightResponse.success else {
                    throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "API error"])
                }
                return flightResponse.data.flatMap { $0.value.values }
            }
            .eraseToAnyPublisher() // унив паблишер
    }
}

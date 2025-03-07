
import Foundation
import Combine

class FlightViewModel: ObservableObject {
    // паблишер
    @Published var origin: String = "MOW"
    @Published var destination: String = ""
    @Published var departDate: String = "2025-06-01"
    @Published var returnDate: String = "2025-06-06"
    
    
    @Published var flights: [Flight] = []
    @Published var cheapestFlights: [Flight] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables: Set<AnyCancellable> = [] // тут ссылки на подписик
    
    private let flightService = FlightService()

    // подписка на изменения
    func searchFlights() {
        isLoading = true
        errorMessage = nil
        
        flightService.fetchFlights(origin: origin, destination: destination, departDate: departDate, returnDate: returnDate)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "Error: \(error.localizedDescription)"
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] flightsData in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.flights = flightsData
                    self?.cheapestFlights = flightsData.sorted(by: { $0.price < $1.price }).prefix(3).map { $0 }
                }
            })
            .store(in: &cancellables)
    }
    
   
    func loadCheapestFlights() {
        flightService.fetchFlights(origin: origin, destination: destination, departDate: departDate, returnDate: returnDate)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "Error loading cheapest flights: \(error.localizedDescription)"
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] flightsData in
                DispatchQueue.main.async {
                    self?.cheapestFlights = flightsData.sorted(by: { $0.price < $1.price }).prefix(3).map { $0 }
                }
            })
            .store(in: &cancellables)
    }
}

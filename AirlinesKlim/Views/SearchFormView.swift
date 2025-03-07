import SwiftUI

struct SearchFormView: View {
    @ObservedObject var viewModel: FlightViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Search Parameters")) {
                TextField("From", text: $viewModel.origin)
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)
                    .autocapitalization(.allCharacters)
                
                TextField("To", text: $viewModel.destination)
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)
                    .autocapitalization(.allCharacters)
                
                VStack(alignment: .leading) {
                    Text("Departure Date")
                    TextField("YYYY-MM-DD", text: $viewModel.departDate)
                        .keyboardType(.numbersAndPunctuation)
                }
                
                VStack(alignment: .leading) {
                    Text("Return Date")
                    TextField("YYYY-MM-DD", text: $viewModel.returnDate)
                        .keyboardType(.numbersAndPunctuation)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.white)
    }
}

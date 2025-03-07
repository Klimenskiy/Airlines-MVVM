import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/klim/Documents/Weather/AirlinesKlim/AirlinesKlim/Main/ContentView.swift", line: 1)
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlightViewModel()
    @State private var showImagePicker = false
    @State private var capturedImage: UIImage?
    @State private var isFormVisible = false
    @State private var isFlightsVisible = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    ScrollView {
                        VStack {
                            if isFormVisible {
                                SearchFormView(viewModel: viewModel)
                                    .frame(height: geometry.size.height * __designTimeFloat("#22585_0", fallback: 0.4))
                                    .transition(.move(edge: .top).combined(with: .opacity))
                                    .animation(.easeInOut(duration: __designTimeFloat("#22585_1", fallback: 0.5)), value: isFormVisible)
                            }
                            
                            SearchButtonView {
                                withAnimation {
                                    viewModel.searchFlights()
                                    isFlightsVisible = __designTimeBoolean("#22585_2", fallback: true)
                                }
                            }
                            
                            if isFlightsVisible {
                                FlightListView(viewModel: viewModel, geometry: geometry)
                                    .animation(.easeInOut(duration: __designTimeFloat("#22585_3", fallback: 0.5)), value: isFlightsVisible)
                            }
                            
                            CheapestFlightsView(viewModel: viewModel, isFlightsVisible: isFlightsVisible)
                        }
                    }
                    
                    CameraButtonView(showImagePicker: $showImagePicker)
                }
            }
            .navigationTitle(__designTimeString("#22585_4", fallback: "Flight Search"))
            .onAppear {
                withAnimation { isFormVisible = __designTimeBoolean("#22585_5", fallback: true) }
                viewModel.loadCheapestFlights()
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker { image in
                    if let image = image {
                        withAnimation { self.capturedImage = image }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

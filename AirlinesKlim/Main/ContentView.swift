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
                                    .frame(height: geometry.size.height * 0.4)
                                    .transition(.move(edge: .top).combined(with: .opacity))
                                    .animation(.easeInOut(duration: 0.5), value: isFormVisible)
                            }
                            
                            SearchButtonView {
                                withAnimation {
                                    viewModel.searchFlights()
                                    isFlightsVisible = true
                                }
                            }
                            
                            if isFlightsVisible {
                                FlightListView(viewModel: viewModel, geometry: geometry)
                                    .animation(.easeInOut(duration: 0.5), value: isFlightsVisible)
                            }
                            
                            CheapestFlightsView(viewModel: viewModel, isFlightsVisible: isFlightsVisible)
                        }
                    }
                    
                    CameraButtonView(showImagePicker: $showImagePicker)
                }
            }
            .navigationTitle("Flight Search")
            .onAppear {
                withAnimation { isFormVisible = true }
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

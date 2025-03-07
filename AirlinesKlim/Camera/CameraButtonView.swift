


import SwiftUI

struct CameraButtonView: View {
    @Binding var showImagePicker: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    withAnimation {
                        showImagePicker.toggle()
                    }
                }) {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(Circle().fill(Color.blue))
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .rotationEffect(showImagePicker ? .degrees(45) : .degrees(0))
                        .animation(.spring(), value: showImagePicker)
                }
                .padding(.leading, 20)
                
                Spacer()
            }
        }
    }
}

import SwiftUI
import AVFoundation
import UIKit

struct CameraView: View {
    @State private var showImagePicker = false
    @State private var capturedImage: UIImage?
    
    var body: some View {
        VStack {
         
            Button(action: {
                self.showImagePicker.toggle()
            }) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding()
                    .background(Circle().fill(Color.blue))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }
            .padding(.bottom, 20)
          
            if let capturedImage = capturedImage {
                Image(uiImage: capturedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding()
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker { image in
                if let image = image {
                    self.capturedImage = image
                    self.saveImageLocally(image: image)
                }
            }
        }
    }
    
  
    private func saveImageLocally(image: UIImage) {
        guard let data = image.pngData() else { return }
        
        let fileManager = FileManager.default
        let fileURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageURL = fileURL.appendingPathComponent("capturedImage.png")
        
        do {
            try data.write(to: imageURL)
            print("Image saved to: \(imageURL.path)")
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
}

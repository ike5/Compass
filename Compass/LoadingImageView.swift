//
//  LoadingImageView.swift
//  Compass
//
//  Created by Ike Maldonado on 7/4/25.
//

import SwiftUI

struct LoadingImageView: View {
    @ObservedObject var compassHeading = CompassHeading()
    @State private var lastHeading: Double = 0
    @State private var loadingProgress: CGFloat = 0
    @State private var timer: Timer?
    @State private var preloadedURL: URL?
    @State private var displayedURL: URL?
    @State private var isLoading = false

    var body: some View {
        ZStack {
            Circle()
                    .trim(from: 0, to: loadingProgress)
                    .stroke(Color.blue, lineWidth: 10)
                    .frame(width: 210, height: 210)
                    .shadow(radius: 7)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: isLoading ? 4.0 : 0), value: loadingProgress)

            if displayedURL != nil {
                CircleImage()
            } else {
                CircleImage()
            }
        }
        .onChange(of: compassHeading.degrees) { oldValue, newValue in
            if abs(newValue - lastHeading) >= 15 {
                startLoaderAndPreload()
                lastHeading = newValue
            }
        }
    }

    func startLoaderAndPreload() {
        // Cancel any running loader
        timer?.invalidate()
        loadingProgress = 0
        isLoading = true

        // Preload the image URL (randomize to prevent caching)
        preloadedURL = URL(string: "https://picsum.photos/500?")

        // Animate the loader
        withAnimation(.linear(duration: 4.0)) {
            loadingProgress = 1.0
        }

        // After 4 seconds, display the preloaded image
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
            displayedURL = preloadedURL
            isLoading = false
            loadingProgress = 0
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
}



#Preview {
    LoadingImageView()
}

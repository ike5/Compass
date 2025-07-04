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
    @State private var headingPaused: Bool = false
    @State private var loadingProgress: CGFloat = 0
    @State private var timer: Timer?
    @State private var secondsPaused: Int = 0
    @State private var imageURL: URL? = nil

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: loadingProgress)
                .stroke(Color.blue, lineWidth: 5)
                .frame(width: 220, height: 220)
                .rotationEffect(.degrees(-90))
            if let url = imageURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
            } else {
                CircleImage() // fallback
            }
        }
        .onChange(of: compassHeading.degrees) { oldValue, newValue in
            if abs(newValue - lastHeading) > 15 {
                resetLoading()
            }
            lastHeading = newValue
        }
    }

    func fetchNewPhoto() {
        print("Fetching new photo...")
        imageURL = URL(string: "https://picsum.photos/200?\(Int.random(in: 0...10000))")
    }

    func resetLoading() {
        timer?.invalidate()
        loadingProgress = 0
        secondsPaused = 0
        headingPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            secondsPaused += 1
            if secondsPaused > 2 && secondsPaused <= 4 {
                withAnimation(.linear(duration: 1)) {
                    loadingProgress = CGFloat(secondsPaused - 2) / 2
                }
            }
            if secondsPaused == 5 {
                fetchNewPhoto()
                timer?.invalidate()
            }
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
}


#Preview {
    LoadingImageView()
}

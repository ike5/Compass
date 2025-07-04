//
//  LoadingImageView.swift
//  Compass
//
//  Created by Ike Maldonado on 7/4/25.
//

import SwiftUI

struct LoadingImageView: View {
    @ObservedObject var compassHeading = CompassHeading()
    @ObservedObject var headingState = HeadingState()
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
                .animation(.linear(duration: isLoading ? 4.0 : 0.0), value: loadingProgress)
            
            if isLoading, let url = displayedURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 7)
            } else {
                CircleImage()
            }
        }
        .onChange(of: compassHeading.degrees) { oldValue, newValue in
            let angleDiff = minimalAngleDifference(newValue, headingState.lastHeading)
            print("newValue: \(newValue), lastHeading: \(headingState.lastHeading), angleDiff: \(angleDiff)")
            if !isLoading && angleDiff >= 30 {
                headingState.lastHeading = newValue
                startLoaderAndPreload()
            }
        }
    }
    
    func startLoaderAndPreload() {
        timer?.invalidate()
        loadingProgress = 0
        isLoading = true
        
        preloadedURL = URL(string: "https://picsum.photos/500")
        
        withAnimation(.linear(duration: 4.0)) {
            loadingProgress = 1.0
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
            displayedURL = preloadedURL
            isLoading = false
            loadingProgress = 0
            
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func minimalAngleDifference(_ a: Double, _ b: Double) -> Double {
        let diff = abs(a - b).truncatingRemainder(dividingBy: 360)
        return diff > 180 ? 360 - diff : diff
    }
}



#Preview {
    LoadingImageView()
}

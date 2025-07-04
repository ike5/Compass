//
//  ContentView.swift
//  Compass
//
//  Created by Ike Maldonado on 7/4/25.
//

import SwiftUI
import SwiftData

struct ContentView : View {
    @ObservedObject var compassHeading = CompassHeading()
    @StateObject var headingState = HeadingState()
    
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 5,
                       height: 50)
            
            ZStack {
                LoadingImageView(compassHeading: compassHeading, headingState: headingState)
                    .rotationEffect(Angle(degrees: -self.compassHeading.degrees))
                
                ForEach(Marker.markers(), id: \.self) { marker in
                    CompassMarkerView(marker: marker,
                                      compassDegrees: -self.compassHeading.degrees)
                }
            }
            .frame(width: 300,
                   height: 300)
            .rotationEffect(Angle(degrees: self.compassHeading.degrees))
            .statusBar(hidden: true)
        }
    }
}

struct Marker: Hashable {
    let degrees: Double
    
    init(degrees: Double) {
        self.degrees = degrees
    }
    
    static func markers() -> [Marker] {
        return[
            Marker(degrees: 0),
            Marker(degrees: 30),
            Marker(degrees: 60),
            Marker(degrees: 90),
            Marker(degrees: 120),
            Marker(degrees: 150),
            Marker(degrees: 180),
            Marker(degrees: 210),
            Marker(degrees: 240),
            Marker(degrees: 270),
            Marker(degrees: 300),
            Marker(degrees: 330)
        ]
    }
    
    func degreeText() -> String {
        return String(format: "%.0f", self.degrees)
    }
}

struct CompassMarkerView: View {
    let marker: Marker
    let compassDegrees: Double
    
    var body: some View {
        VStack{
            Text("\(marker.degreeText())")
                .fontWeight(.light)
                .rotationEffect(self.textAngle())
            Capsule()
                .frame(width:self.capsuleWidth(),
                       height:self.capsuleHeight())
                .foregroundColor(self.capsuleColor())
                .padding(.bottom, 120)
            Spacer()
        }
        .rotationEffect(Angle(degrees: marker.degrees))
    }
    
    private func capsuleWidth() -> CGFloat {
        return self.marker.degrees == 0 ? 7:3
    }
    private func capsuleHeight() -> CGFloat {
        return self.marker.degrees == 0 ? 45:30
    }
    private func capsuleColor() -> Color {
        return self.marker.degrees == 0 ? .red : .gray
    }
    private func textAngle() -> Angle {
        return Angle(degrees: self.compassDegrees - self.marker.degrees)
    }
}

#Preview {
    ContentView()
}

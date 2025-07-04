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
            MapView()
            
            VStack {
                Capsule()
                    .frame(width: 5,
                           height: 50)
                
                ZStack {
                    LoadingImageView(compassHeading: compassHeading, headingState: headingState)
                        .rotationEffect(Angle(degrees: -self.compassHeading.degrees))
                    
                    ForEach(Markers.markers(), id: \.self) { marker in
                        CompassMarkerView(marker: marker,
                                          compassDegrees: -self.compassHeading.degrees)
                    }
                }
                .frame(width: 300,
                       height: 300)
                .rotationEffect(Angle(degrees: self.compassHeading.degrees))
                .statusBar(hidden: true)
            }
            .offset(y: -160)
            .padding(.bottom, -200)
            
            VStack(alignment: .leading) {
                Text("La Paz")
                    .font(.title)
                HStack {
                    Text("Camino Real Neighborhood")
                    
                    Spacer()
                    Text("Baja California Sur")
                    
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                Text("About La Paz")
                    .font(.title2)
                Text("La Paz, Baja California Sur is a coastal city on the Sea of Cortez in northwestern Mexico, known for its relaxed vibe, stunning sunsets, and access to world-class marine life. As the capital of Baja California Sur, it blends local culture with modern comforts. ")
            }
            .padding()
            Spacer()
        }
        
        
    }
}

struct Markers: Hashable {
    let degrees: Double
    
    init(degrees: Double) {
        self.degrees = degrees
    }
    
    static func markers() -> [Markers] {
        return[
            Markers(degrees: 0),
            Markers(degrees: 30),
            Markers(degrees: 60),
            Markers(degrees: 90),
            Markers(degrees: 120),
            Markers(degrees: 150),
            Markers(degrees: 180),
            Markers(degrees: 210),
            Markers(degrees: 240),
            Markers(degrees: 270),
            Markers(degrees: 300),
            Markers(degrees: 330)
        ]
    }
    
    func degreeText() -> String {
        return String(format: "%.0f", self.degrees)
    }
}

struct CompassMarkerView: View {
    let marker: Markers
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
        return self.marker.degrees == 0 ? 20:10
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

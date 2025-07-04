//
//  MapView.swift
//  Compass
//
//  Created by Ike Maldonado on 7/3/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 24.050_126, longitude: -110.284_814),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )

    var body: some View {
        Map(position: $position) {
            Marker("Me!", coordinate: PinLocation.example.coordinate)
                .tint(.red)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PinLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D

    static let example = PinLocation(
        name: "Me!",
        coordinate: CLLocationCoordinate2D(latitude: 24.050_126, longitude: -110.284_814)
    )
}

#Preview {
    MapView()
}

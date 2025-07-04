//
//  CircleImage.swift
//  Compass
//
//  Created by Ike Maldonado on 7/4/25.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://picsum.photos/500")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            ProgressView()
        }
        .frame(width: 200, height: 200)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 7)
    }
}

#Preview {
    CircleImage()
}

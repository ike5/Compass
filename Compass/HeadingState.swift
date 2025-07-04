//
//  HeadingState.swift
//  Compass
//
//  Created by Ike Maldonado on 7/4/25.
//

import Foundation
import Combine

class HeadingState: ObservableObject {
    @Published var lastHeading: Double = 0
}

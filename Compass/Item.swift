//
//  Item.swift
//  Compass
//
//  Created by Ike Maldonado on 7/4/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

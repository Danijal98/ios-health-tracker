//
//  HealthData.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//

import Foundation

struct HealthData: Identifiable, Codable {
    var id: UUID?
    var heartRate: Int?
    var oxygenSaturation: Int?
    var createdTime: String?
}

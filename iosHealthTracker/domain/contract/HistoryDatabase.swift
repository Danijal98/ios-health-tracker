//
//  HistoryDatabase.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/4/25.
//


import Foundation

protocol HistoryDatabase {
    func insert(_ healthData: HealthData) async throws
    func getAll() async throws -> [HealthData]
    func deleteAll() async throws
}

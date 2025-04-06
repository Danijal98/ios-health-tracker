//
//  CoreDataHistoryRepository.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/4/25.
//


import Foundation
import CoreData

final class CoreDataHistoryDatabase: HistoryDatabase {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func insert(_ healthData: HealthData) async throws {
        let entity = HealthDataEntity(context: context)
        entity.id = UUID()
        entity.timestamp = Date()
        entity.heartRate = Int64(healthData.heartRate ?? 0)
        entity.oxygenSaturation = Int64(healthData.oxygenSaturation ?? 0)
        
        try context.save()
    }
    
    func getAll() async throws -> [HealthData] {
        let request: NSFetchRequest<HealthDataEntity> = HealthDataEntity.fetchRequest()
        let results = try context.fetch(request)
        
        return results.map {
            HealthData(
                id: $0.id,
                heartRate: Int($0.heartRate),
                oxygenSaturation: Int($0.oxygenSaturation),
                createdTime: $0.timestamp!.toLocalString() // It is always set
            )
        }
    }
    
    func deleteAll() async throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = HealthDataEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
        try context.save()
    }
}

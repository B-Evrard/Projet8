//
//  SleepRepository.swift
//  Arista
//
//  Created by Bruno Evrard on 18/12/2024.
//

import Foundation
import CoreData

struct SleepRepository {
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getSleepSessions() throws -> [Sleep] {
        let request = Sleep.fetchRequest()
        request.sortDescriptors =  [NSSortDescriptor(SortDescriptor<Sleep>(\.startDate, order: .reverse) )]
        return try viewContext.fetch (request).map { $0 }
    }
    
    func addSleep(model: SleepModel) throws {
        let sleep = Sleep(context: viewContext)
        sleep.startDate = model.startDate
        sleep.endDate = model.endDate
        sleep.quality = Int16(model.quality)
        try viewContext.save()
    }
    
    
    
}

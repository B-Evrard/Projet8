//
//  ExerciseRepository.swift
//  Arista
//
//  Created by Bruno Evrard on 18/12/2024.
//

import Foundation
import CoreData

struct ExerciseRepository {
    
    let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
        
        
    func getExercise() throws -> [Exercise] {
        let request = Exercise.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(SortDescriptor<Exercise>(\.startDate, order: .reverse))]
        return try viewContext.fetch (request).map { $0 }
    }
   
   
    func addExercise(model: ExerciseModel) throws {
        let exercise = Exercise(context: viewContext)
        exercise.type = model.type.rawValue
        exercise.intensity = Int16(model.intensity)
        exercise.startDate = model.startDate
        exercise.endDate = model.endDate
        try viewContext.save()
    }
    
    func deleteAllExercises() throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try viewContext.execute(batchDeleteRequest)
    }
    
    
}


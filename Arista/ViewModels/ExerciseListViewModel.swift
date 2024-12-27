//
//  ExerciseListViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class ExerciseListViewModel: ObservableObject {
    @Published var exercises = [Exercise]()

    init() {
        fetchExercises()
    }

    private func fetchExercises() {
       
        do {
            let data = ExerciseRepository()
            exercises = try data.getExercise()
            
        } catch {
            
        }
    }
    
    func refreshExercises() {
        fetchExercises()
    }
    
    func iconForCategory(_ category: String) -> String {
        if let exerciseType = TypeExercise.from(rawValue: category) {
            return exerciseType.icon
        } else {
            return "questionmark"
        }
    }
    
    func deleteExercise() {
        do {
            let data = ExerciseRepository()
            try data.deleteAllExercises()
            fetchExercises()
        } catch {
            
        }
    }
}



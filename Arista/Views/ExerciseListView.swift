//
//  ExerciseListView.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var viewModel: ExerciseListViewModel
    @State private var showingAddExerciseView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.exercises) { exercise in
                    HStack {
                        Image(systemName: exercise.type.icon)
                            .frame(width: 20, height: 10)
                        VStack(alignment: .leading) {
                            Text(exercise.type.rawValue)
                                .font(.headline)
                            Text("Durée: \(exercise.duration)")
                                .font(.subheadline)
                            Text(exercise.startDateFormatted)
                                .font(.subheadline)
                            
                        }
                        Spacer()
                        Circle()
                            .fill(exercise.intensityIndicator)
                            .frame(width: 10, height: 10)
                        
                    }.listRowBackground(Color.white.opacity(0.5))
                }
                .onDelete(perform: deleteExercise)
            }
            .scrollContentBackground(.hidden)
            .background(Image("Fond"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Exercices")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                showingAddExerciseView = true
            }) {
                Image(systemName: "plus")
            })
            
        }
        .sheet(isPresented: $showingAddExerciseView, onDismiss: {
            viewModel.refreshExercises()})
        {
            AddExerciseView(viewModel: AddExerciseViewModel())
        }
        .alert("Erreur", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Une erreur est survenue")
        }
        
        
        
        
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        for index in offsets {
            let exercise = viewModel.exercises[index]
            viewModel.deleteExercise(exercise)
        }
    }
    
}



#Preview {
    ExerciseListView(viewModel: ExerciseListViewModel())
}

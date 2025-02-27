//
//  SleepHistoryView.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import SwiftUI

struct SleepHistoryView: View {
    @ObservedObject var viewModel: SleepHistoryViewModel
    @State private var showingAddSleepView = false
    
    var body: some View {
        NavigationView {
            List(viewModel.sleepSessions) { session in
                HStack {
                    QualityIndicator(quality: Int(session.quality))
                        .padding()
                    VStack(alignment: .leading) {
                        Text("Début : \(session.startDateFormatted)")
                        
                        Text("Fin : \(session.endDateFormatted)")
                    }
                } .listRowBackground(Color.white.opacity(0.5))
            }
           
            .scrollContentBackground(.hidden)
            .background(Image("Fond"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Sommeil")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                showingAddSleepView = true
            }) {
                Image(systemName: "plus")
            })
            
        }
        .sheet(isPresented: $showingAddSleepView, onDismiss: {
            viewModel.refreshSleepSessions()})
        {
            AddSleepView(viewModel: AddSleepViewModel())
        }
        .alert("Erreur", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Une erreur est survenue")
        }
    }
}

struct QualityIndicator: View {
    let quality: Int

    var body: some View {
        ZStack {
            Circle()
                .stroke(qualityColor(Int(quality)), lineWidth: 5)
                .foregroundColor(qualityColor(Int(quality)))
                .frame(width: 35, height: 35)
            Text("\(quality)")
                .foregroundColor(qualityColor(Int(quality)))
        }
    }

    func qualityColor(_ quality: Int) -> Color {
        switch (100-quality) {
        case 0...39:
            return .green
        case 40...69:
            return .blue
        case 70...100:
            return .red
        default:
            return .gray
        }
    }
}

#Preview {
    
    SleepHistoryView(viewModel: SleepHistoryViewModel())
}


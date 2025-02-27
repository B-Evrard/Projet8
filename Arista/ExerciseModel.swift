//
//  ExerciseModel.swift
//  Arista
//
//  Created by Bruno Evrard on 30/12/2024.
//

import Foundation
import SwiftUICore

struct ExerciseModel: Identifiable {
    
    var id: UUID = UUID()
    var objectID: String
    
    var type: ExerciseType
    var intensity: Double
    var startDate: Date
    var endDate: Date

    var duration: String {
         "\(Int(round(endDate.timeIntervalSince(startDate)/60))) minutes"
    }
    
    
    var intensityIndicator: Color {
        switch intensity {
        case 0...6:
            return .green
        case 7...15:
            return .yellow
        case 16...20:
            return .red
        default:
            return .gray
        }
    }
    
    var startDateFormatted: String {
        Utils.formattedDate(startDate)
    }
    
    var endDateFormatted: String {
        Utils.formattedDate(endDate)
    }
    
    
}

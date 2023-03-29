//
//  BreathingModel.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 25.03.2023.
//

import Foundation

struct BreathingModel {
    let title: String
    let description: String
    let duration: Int
    let steps: [String]
    let note: String?
    
    let inhaleTime: Int
    let holdTime: Int
    let exhaleTime: Int
    let totalTime: Int?
    
    
    init(title: String, description: String, duration: Int, steps: [String], note: String?, inhaleTime: Int, holdTime: Int, exhaleTime: Int) {
        self.title = title
        self.description = description
        self.duration = duration
        self.steps = steps
        self.note = note
        
        self.inhaleTime = 0
        self.holdTime = inhaleTime
        self.exhaleTime = inhaleTime + holdTime
        self.totalTime = inhaleTime + holdTime + exhaleTime
    }
}

enum BreathingState {
    case inhaling
    case hold
    case exhaling
    
    var title: String {
        switch self {
        case .inhaling:
            return "Inhale"
        case .hold:
            return "Hold your breath"
        case .exhaling:
            return "Exhale.."
        }
    }
}

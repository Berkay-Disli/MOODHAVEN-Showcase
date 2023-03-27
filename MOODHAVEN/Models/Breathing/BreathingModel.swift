//
//  BreathingModel.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 25.03.2023.
//

import Foundation

struct BreathingModel {
    let inhaleTime: Int
    let holdTime: Int
    let exhaleTime: Int
    let totalTime: Int?
    
    init(inhaleTime: Int, holdTime: Int, exhaleTime: Int) {
        self.inhaleTime = 0
        self.holdTime = inhaleTime
        self.exhaleTime = inhaleTime + holdTime
        self.totalTime = inhaleTime + holdTime + exhaleTime
    }
    
    
}


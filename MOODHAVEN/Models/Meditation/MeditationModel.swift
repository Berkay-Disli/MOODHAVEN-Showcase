//
//  MeditationModel.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 6.04.2023.
//

import Foundation

struct MeditationModel: Identifiable {
    let id: String
    let title: String
    let description: String
    let duration: TimeInterval // example: "7:37"
    let audioFileName: String // name of the audio file stored locally in the app
    let author: String
    let category: String?
    let image: String
    
}

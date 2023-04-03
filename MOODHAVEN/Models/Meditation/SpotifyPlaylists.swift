//
//  SpotifyPlaylists.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 4.04.2023.
//

import Foundation

enum SpotifyPlaylists: String, CaseIterable {
    case guidedMeditations, meditationMusic, natureSounds, whiteNoise
    case ambientMusic, ASMRsounds, binauralBeats
    
    var title: String {
        switch self {
        case .guidedMeditations:
            return "Guided Meditations"
        case .meditationMusic:
            return "Meditation Music"
        case .natureSounds:
            return "Nature"
        case .whiteNoise:
            return "White Noise"
        case .ambientMusic:
            return "Ambient"
        case .ASMRsounds:
            return "ASMR"
        case .binauralBeats:
            return "Binaural"
        }
    }
    
    // add link url to spotify
}

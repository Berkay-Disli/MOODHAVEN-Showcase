//
//  SpotifyPlaylists.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 4.04.2023.
//

import Foundation

enum SpotifyPlaylists: String, CaseIterable {
    case meditationMusic, natureSounds, whiteNoise
    case ambientMusic, binauralBeats
    
    var title: String {
        switch self {
        case .meditationMusic:
            return "Meditation Music"
        case .natureSounds:
            return "Nature Sounds"
        case .whiteNoise:
            return "White \nNoise"
        case .ambientMusic:
            return "Ambient Music"
        case .binauralBeats:
            return "Binaural Beats"
        }
    }
    
    // add link url to spotify
    
    var url: URL? {
        switch self {
        case .meditationMusic:
            return URL(string: "https://youtu.be/gw_gQ-4Lr30")
        case .natureSounds:
            return URL(string: "https://youtu.be/gw_gQ-4Lr30")
        case .whiteNoise:
            return URL(string: "https://youtu.be/gw_gQ-4Lr30")
        case .ambientMusic:
            return URL(string: "https://youtu.be/gw_gQ-4Lr30")
        case .binauralBeats:
            return URL(string: "https://youtu.be/gw_gQ-4Lr30")
        }
    }
}

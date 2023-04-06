//
//  SmallHMusicCardView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 6.04.2023.
//

import SwiftUI

struct SmallHMusicCardView: View {
    
    let fgColor: Color
    let model: SpotifyPlaylists
    
    
    var body: some View {
        if let url = model.url {
            Link(destination: url) {
                VStack(alignment: .leading, spacing: 8) {
                    //RoundedRectangle(cornerRadius: 6).fill(fgColor.opacity(0.2).gradient)
                    Image(model.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height:70)
                        .cornerRadius(6)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 6).stroke(fgColor, lineWidth: 0.1)
                                .padding(1)
                        })
                    
                    VStack(alignment: .leading) {
                        Text(model.title)
                            .font(.system(size: 13))
                            
                        Text(model.description)
                            .font(.system(size: 10))
                            .lineLimit(2, reservesSpace: true)
                            .multilineTextAlignment(.leading)

                    }
                    .foregroundColor(fgColor)
                }
                .frame(width: 130)
            }
        }

    }
}

struct SmallHMusicCardView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())    }
}

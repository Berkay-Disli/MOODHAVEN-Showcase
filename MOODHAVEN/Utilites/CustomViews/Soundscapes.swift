//
//  Soundscapes.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct Soundscapes: View {
    
    let fgColor: Color
    let bgColor: Color
    
    var body: some View {
        
        
        HStack(alignment: .top, spacing: 0) {
            ForEach(SpotifyPlaylists.allCases, id:\.self) { item in
                if let url = item.url {
                    Link(destination: url) {
                        VStack(spacing: 10) {
                            Circle().stroke(fgColor, lineWidth: 2)
                                .frame(width: 47.5, height: 47.5)
                            
                            Text(item.title)
                                .font(.system(size: 10))
                                .lineLimit(2, reservesSpace: true)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(fgColor)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 60)
                        .padding(.bottom, 4)
                        .hAlign(.center)
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
        
    }
}

struct Soundscapes_Previews: PreviewProvider {
    static var previews: some View {
        //Soundscapes(fgColor: .fg1, bgColor: .set1)
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}

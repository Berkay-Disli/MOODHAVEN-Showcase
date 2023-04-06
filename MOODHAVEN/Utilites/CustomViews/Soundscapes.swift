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
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 14) {
                ForEach(SpotifyPlaylists.allCases, id:\.self) { item in
                    if let url = item.url {
                        Link(destination: url) {
                            Text(item.title)
                                .font(.system(size: 13))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .background {
                                    RoundedRectangle(cornerRadius: 6).stroke(fgColor, lineWidth: 1)
                                        .padding(1)
                                }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
        }
        

        
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

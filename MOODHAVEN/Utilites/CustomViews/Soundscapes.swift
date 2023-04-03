//
//  Soundscapes.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct Soundscapes: View {
    
    let fgColor: Color
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 8) {
                ForEach(SpotifyPlaylists.allCases, id:\.self) { item in
                    VStack {
                        RoundedRectangle(cornerRadius: 7).stroke(fgColor, lineWidth: 2)
                            .frame(width: 55, height: 55)
                        
                        Text(item.title)
                            .font(.system(size: 14))
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(fgColor)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 80)
                    .padding(4)
                    .id(item)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}

struct Soundscapes_Previews: PreviewProvider {
    static var previews: some View {
        Soundscapes(fgColor: .fg1)
    }
}

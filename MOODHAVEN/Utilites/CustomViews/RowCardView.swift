//
//  RowCardView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct RowCardView: View {
    let fgColor: Color
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 5).fill(fgColor.opacity(0.2).gradient)
                .frame(width: 50, height: 50)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5).stroke(fgColor, lineWidth: 0.1)
                })
            
            VStack(alignment: .leading, spacing: 3) {
                Text("4-7-8 Breathing")
                    .font(.system(size: 14))
                
                Text("Calm your mind by slowing down your breathing.")
                    .fontWeight(.light)
                    .font(.system(size: 12))
                    .foregroundColor(fgColor)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "waveform.path")
                    .font(.system(size: 14))
            }

        }
        .padding(.vertical, 6)
    }
}

struct RowCardView_Previews: PreviewProvider {
    static var previews: some View {
        RowCardView(fgColor: .fg1, title: "4-7-8 Breathing", description: "Calm your mind by slowing down your breathing.")
    }
}

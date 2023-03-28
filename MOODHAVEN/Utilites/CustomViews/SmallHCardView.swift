//
//  SmallHCardView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct SmallHCardView: View {
    let fgColor: Color
    let category: String // change the name maybe later
    let title: String
    let duration: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 5).fill(fgColor.opacity(0.2).gradient)
                .frame(height:70)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5).stroke(fgColor, lineWidth: 0.1)
                })
            
            VStack(alignment: .leading) {
                Text(category)
                    .fontWeight(.light)
                    .font(.system(size: 11))
                
                Text(title)
                    .font(.system(size: 14))
                    .lineLimit(2)

                Text("\(duration) min.")
                    .italic()
                    .font(.system(size: 11))
            }
            .foregroundColor(fgColor)
        }
    }
}

struct SmallHCardView_Previews: PreviewProvider {
    static var previews: some View {
        SmallHCardView(fgColor: .fg1, category: "Mindful Start", title: "Reflecting on Self-Compassion", duration: 12)
    }
}

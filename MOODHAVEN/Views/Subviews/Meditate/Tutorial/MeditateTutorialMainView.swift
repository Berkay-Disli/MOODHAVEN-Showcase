//
//  MeditateTutorialMainView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 4.04.2023.
//

import SwiftUI

struct MeditateTutorialMainView: View {
    
    let fgColor: Color
    let bgColor: Color
    
    @State private var pages: MeditateTutorialPages = .first
    
    var body: some View {
        VStack {
            switch pages {
            case .first:
                MeditateTutorialPage1(pages: $pages, fgColor: fgColor, bgColor: bgColor)
                    .transition(.opacity.animation(.easeInOut))
                    .preferredColorScheme(.dark)

            case .second:
                MeditateTutorialPage2(pages: $pages, fgColor: fgColor, bgColor: bgColor)
                    .transition(.opacity.animation(.easeInOut))
                    .preferredColorScheme(.dark)

            case .third:
                MeditateTutorialPage3()
                    .transition(.opacity.animation(.easeInOut))
                    .preferredColorScheme(.dark)

            }
        }
        .preferredColorScheme(.dark)
    }
}

struct MeditateTutorialMainView_Previews: PreviewProvider {
    static var previews: some View {
        MeditateTutorialMainView(fgColor: .fg8, bgColor: .set8)
    }
}

//
//  ScrollUpButton.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 4.04.2023.
//

import SwiftUI

struct ScrollUpButton: View {
    var mainProxy: ScrollViewProxy
    
    var body: some View {
        // Tap button to scroll up!
        Button {
            withAnimation(.easeInOut) {
                mainProxy.scrollTo("topView", anchor: .init(x: 0, y: 1))
            }
        } label: {
            Image(systemName: "arrow.up")
                .font(.system(size: 14))
                .padding()
                
        }
        .padding(.top, -20)
        .padding(.bottom, 55)

    }
}

/*
struct ScrollUpButton_Previews: PreviewProvider {
    static var previews: some View {
        ScrollUpButton(proxy: .)
    }
}
*/

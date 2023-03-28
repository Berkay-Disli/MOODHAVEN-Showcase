//
//  Soundscapes.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct Soundscapes: View {
    @Binding var soundscapeAnimationCompleted: Bool
    let fgColor: Color
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(1...7, id:\.self) { item in
                        VStack {
                            Circle().stroke(fgColor, lineWidth: 2)
                                .frame(width: 55, height: 55)
                            
                            Text("Item \(item)")
                                .font(.system(size: 14))
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(fgColor)
                        }
                        .frame(width: 60)
                        .padding(4)
                        .id(item)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .onAppear {
                if !soundscapeAnimationCompleted {
                    proxy.scrollTo(7)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut) {
                            proxy.scrollTo(1, anchor: .trailing)
                        }
                        self.soundscapeAnimationCompleted = true
                    }
                    
                }
            }
        }
    }
}

struct Soundscapes_Previews: PreviewProvider {
    static var previews: some View {
        Soundscapes(soundscapeAnimationCompleted: .constant(false), fgColor: .fg1)
    }
}

//
//  MeditateView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI

struct MeditateView: View {
    @State private var breathingState = BreathingState.hold
    
    let fgColor: Color
    let bgColor: Color
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollViewReader { mainProxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 24) {
                            
                            GreetingHeaderTextView(text: "Meditate")
                                .padding(.top, 24)
                            
                            // MARK: Featured
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(1...5, id:\.self) { item in
                                        RoundedRectangle(cornerRadius: 10).fill(fgColor.opacity(0.2).gradient)
                                            .frame(width: 260, height: 380)
                                            .overlay(content: {
                                                RoundedRectangle(cornerRadius: 10).stroke(fgColor, lineWidth: 0.1)
                                            })
                                        // Shadows are optional!
                                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                                             
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            
                            // MARK: Soundscapes
                            Soundscapes(fgColor: fgColor)
                            
                            
                        }
                    }
                    .background(bgColor)
                    
                }
                
                // MARK: Zstack Toolbar Menu
                Menu {
                    Button {
                        
                    } label: {
                        Label("Guide", systemImage: "info.circle")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .padding()
                }
                .frame(height: 80, alignment: .bottom)
                .hAlign(.trailing)
                .background {
                    Rectangle().fill(LinearGradient(colors: [bgColor, bgColor, .clear], startPoint: .top, endPoint: .bottom))
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
}

struct MeditateView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}

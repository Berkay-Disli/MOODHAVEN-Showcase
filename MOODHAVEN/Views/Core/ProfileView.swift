//
//  ProfileView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI

struct ProfileView: View {
    let fgColor: Color
    let bgColor: Color
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollViewReader { mainProxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 24) {
                            
                            GreetingHeaderTextView(text: "Berkay Dişli")
                                .padding(.top, 24)
                            
                            Text(verbatim: "berkay.dsli@gmail.com")
                                .font(.system(size: 15))
                                .foregroundColor(Color(uiColor: .systemGray))
                                .hAlign(.leading)
                                .padding(.leading)
                                .padding(.top, -20)
                            
                            // MARK: Personal
                            VStack(alignment: .leading, spacing: 24) {
                                HStack {
                                    Image(systemName: "heart")
                                    Text("Favourites")
                                }
                                
                                HStack {
                                    Image(systemName: "calendar")
                                    Text("Schedule")
                                }
                                
                                HStack {
                                    Image(systemName: "chart.bar.xaxis")
                                    Text("Statistics")
                                }
                                
                                Button {
                                    
                                } label: {
                                    Text("Sign Out")
                                        .padding(.vertical, 12)
                                        .frame(maxWidth: .infinity)
                                        .background {
                                            Capsule().stroke(fgColor, lineWidth: 1)
                                                
                                            
                                        }
                                        .padding(.horizontal)
                                }
                                .hAlign(.center)

                            }
                            .hAlign(.leading)
                            .padding(.horizontal)
                            
                            
                            
                            ScrollUpButton(mainProxy: mainProxy)
                            
                            
                            
                        }
                        .background(bgColor)
                    }
                    
                    // MARK: Zstack Toolbar Menu
                    Menu {
                        Button {
                            
                        } label: {
                            Label("Background sound", systemImage: "speaker.wave.3")
                        }
                        
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
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}

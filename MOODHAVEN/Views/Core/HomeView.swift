//
//  HomeView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var navVM: NavigationViewModel
    
    @State private var progress = 35.0
    
    
    var body: some View {
        // preset4 is gone for now.
        // preset1, preset5 and preset10 are alike.
        let fgColor = navVM.appColorPreset.colorSet.fgColor
        let bgColor = navVM.appColorPreset.colorSet.bgColor
        
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollView(content: {
                    LazyVStack(spacing: 24) {
                        // MARK: Header with progress gauge
                        VStack(spacing: 16) {
                            Text("Namaste!")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .lineLimit(2)
                                .hAlign(.leading)
                                .padding(.horizontal)
                                
                            
                            Text("If you change the way you look at things, the things you look at change. -*Wayne Dyer*")
                                .foregroundColor(fgColor)
                                .font(.system(size: 14))
                                .hAlign(.leading)
                                .padding(.horizontal)
                                
                            // Soundscapes
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
                                    proxy.scrollTo(7)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        withAnimation(.easeInOut) {
                                            proxy.scrollTo(1, anchor: .trailing)
                                        }
                                    }
                                }
                            }
                            
                            
                            
                            
                            Button {
                                navVM.changeTab(.profile)
                            } label: {
                                Gauge(value: progress, in: 0...100) {
                                    Text("Daily progress")
                                        .font(.system(size: 14))
                                        .fontWeight(.light)
                                } currentValueLabel: {
                                    Text("%\(progress.formatted())")
                                        //.fontWeight(.light)
                                }
                                .gaugeStyle(.accessoryLinearCapacity)
                                .padding(.horizontal)
                            }

                            
                        }
                        .foregroundColor(fgColor)
                        
                        // Big Cards
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(1...5, id:\.self) { item in
                                    RoundedRectangle(cornerRadius: 8).fill(fgColor)
                                        .frame(width: 130, height: 160)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        
                        // Section-1 / No ScrollView
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Today's meditations")
                                .font(.system(size: 18))
                                .foregroundColor(fgColor)
                                //.fontWeight(.light)
                                .hAlign(.leading)
                            
                            HStack(spacing: 16) {
                                ForEach(1...2, id:\.self) { item in
                                    RoundedRectangle(cornerRadius: 5).fill(fgColor.opacity(0.2).gradient)
                                        .frame(height:90)
                                        .overlay(content: {
                                            RoundedRectangle(cornerRadius: 5).stroke(fgColor, lineWidth: 0.2)
                                        })
                                        .overlay(alignment: .topLeading) {
                                            VStack(alignment: .leading) {
                                                
                                                Text("Mindful Start")
                                                    .fontWeight(.light)
                                                    .font(.system(size: 11))
                                                
                                                Text("Reflecting on Self-Compassion")
                                                    .font(.system(size: 15))
                                                    .lineLimit(2)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                Spacer()
                                                Text("12 min.")
                                                    .italic()
                                                    .font(.system(size: 11))
                                            }
                                            .padding(10)
                                        }
                                }
                            }
                        
                        }
                        .padding(.horizontal)
                        
                        // Section-2 / With ScrollView
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Breathing exercises")
                                .font(.system(size: 18))
                                .foregroundColor(fgColor)
                                .hAlign(.leading)
                            
                            RoundedRectangle(cornerRadius: 5).fill(fgColor.opacity(0.2).gradient)
                                .frame(height: 110)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 5).stroke(fgColor, lineWidth: 0.2)
                                })
                                .overlay(alignment: .topLeading) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("4-7-8 Breathing")
                                                .font(.system(size: 18))
                                            Spacer()
                                            Image(systemName: "waveform.path")
                                                .font(.system(size: 14))
                                                .foregroundColor(fgColor)
                                        }
                                        
                                        Text("Reduce your anxiety and calm your mind by slowing down your breathing and calming your mind.")
                                            .fontWeight(.light)
                                            .font(.system(size: 13))
                                            .lineLimit(2, reservesSpace: true)
                                        
                                        Spacer()
                                        HStack {
                                            Text("MOODHAVEN")
                                                .italic()
                                            Text("-")
                                                .italic()
                                            Text("3 min.")
                                                .italic()
                                                
                                            
                                            Spacer()
                                            Text("Start")
                                                .font(.system(size: 13))
                                                
                                        }
                                        .font(.system(size: 12))
                                        
                                    }
                                    .padding()
                                }
                                .onTapGesture {
                                        navVM.changeTab(.breathe)
                                }
                        
                        }
                        .padding(.horizontal)
                        
                        


                        
                        Spacer()
                            
                    }
                    .padding(.top, 24)
                })
                .onAppear {
                    // MARK: Debugging purposes only for now
                    navVM.changeColorPreset(colorPreset: .preset7)
                }
                .vAlign(.center)
                .hAlign(.center)
                .background(bgColor)
                
                
                // MARK: Zstack Toolbar Menu
                Menu {
                    Button {
                        
                    } label: {
                        Label("Options will be here", systemImage: "gearshape")
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
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationViewModel())
    }
}

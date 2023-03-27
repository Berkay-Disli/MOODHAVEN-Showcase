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
                        // MARK: Header
                        VStack(spacing: 16) {
                            Text("Welcome to \n**MOODHAVEN.**")
                                .font(.title)
                                .fontWeight(.light)
                                .lineLimit(2)
                                .hAlign(.leading)
                                .padding(.horizontal)
                                
                            
                            Text("If you change the way you look at things, the things you look at change. -*Wayne Dyer*")
                                .foregroundColor(fgColor)
                                .font(.system(size: 16))
                                .hAlign(.leading)
                                .padding(.horizontal)
                                
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 2) {
                                    ForEach(1...7, id:\.self) { item in
                                        VStack {
                                            Circle().stroke(fgColor, lineWidth: 2)
                                                .frame(width: 63, height: 63)
                                            
                                            Text("Item \(item)")
                                                
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        .frame(width: 75)
                                        .padding(4)
                                        
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                            }
                            
                            
                            
                            
                            Button {
                                navVM.changeTab(.profile)
                            } label: {
                                Gauge(value: progress, in: 0...100) {
                                    Text("Daily progress")
                                        .font(.system(size: 16))
                                        .fontWeight(.light)
                                } currentValueLabel: {
                                    Text("%\(progress.formatted())")
                                        //.fontWeight(.light)
                                }
                                .gaugeStyle(.accessoryLinearCapacity)
                                .padding(.horizontal)
                                .padding(.vertical,4)
                            }

                            
                        }
                        
                        
                        
                        // Section-1 / No ScrollView
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Today's meditation")
                                .font(.title3)
                                .foregroundColor(fgColor)
                                //.fontWeight(.light)
                                .hAlign(.leading)
                            
                            RoundedRectangle(cornerRadius: 5).fill(fgColor.opacity(0.2).gradient)
                                .frame(height: 110)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 5).stroke(fgColor, lineWidth: 0.2)
                                })
                                .overlay(alignment: .topLeading) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Mindful Start")
                                            Spacer()
                                            Image(systemName: "sun.haze")
                                                .foregroundColor(fgColor)
                                        }
                                        .fontWeight(.light)
                                        .font(.system(size: 14))

                                        Text("Reflecting on Self-Compassion")
                                            .font(.system(size: 18))
                                        
                                        HStack {
                                            Text("MOODHAVEN")
                                                .italic()
                                            Text("-")
                                                .italic()
                                            Text("12 min.")
                                                .italic()
                                                
                                            
                                            Spacer()
                                            Text("Start")
                                                .font(.system(size: 13))
                                                
                                        }
                                        .font(.system(size: 12))
                                        .vAlign(.bottom)
                                    }
                                    .padding()
                                }
                        
                        }
                        .padding(.horizontal)
                        
                        // Section-2 / With ScrollView
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Breathing exercises")
                                .font(.title3)
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
                    navVM.changeColorPreset(colorPreset: .preset6)
                }
                .vAlign(.center)
                .hAlign(.center)
                .background(bgColor)
                
                /*
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .padding(.trailing).padding(.bottom, 18)
                        .frame(height: 70, alignment: .bottom)
                        .fontWeight(.semibold)
                        .hAlign(.trailing)
                        .background {
                            Rectangle().fill(LinearGradient(colors: [bgColor, bgColor, .clear], startPoint: .top, endPoint: .bottom))
                        }
                        
                        .edgesIgnoringSafeArea(.top)
                        .padding(.bottom, 60)
                        
                        
                }
                */
                
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

                
                
                
                /*
                Menu("...") {
                    Button {
                        
                    } label: {
                        Label("Options will be here", systemImage: "gearshape")
                    }
                    
                    
                }
                .padding(.trailing).padding(.bottom, 18)
                .frame(height: 70, alignment: .bottom)
                .hAlign(.trailing)
                .background {
                    Rectangle().fill(LinearGradient(colors: [bgColor, bgColor, .clear], startPoint: .top, endPoint: .bottom))
                }
                .border(.cyan)
                .edgesIgnoringSafeArea(.top)
                */
                
                
                
                
                
                
                
                /*
                .padding(.trailing).padding(.bottom, 18)
                .frame(height: 70, alignment: .bottom)
                .fontWeight(.semibold)
                .hAlign(.trailing)
                .background {
                    Rectangle().fill(LinearGradient(colors: [bgColor, bgColor, .clear], startPoint: .top, endPoint: .bottom))
                        .border(.cyan)
                }
                
                .edgesIgnoringSafeArea(.top)
                //.padding(.bottom, 60)
                .border(.red)
                */


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

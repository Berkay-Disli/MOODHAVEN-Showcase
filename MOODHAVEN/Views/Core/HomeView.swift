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
            VStack(spacing: 24) {
                // MARK: Header
                VStack(spacing: 16) {
                    Text("Welcome to **MOODHAVEN.**")
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .lineLimit(2)
                        .hAlign(.leading)
                        .padding(.top)
                    
                    Text("If you change the way you look at things, the things you look at change. -*Wayne Dyer*")
                        .foregroundColor(fgColor)
                        .font(.system(size: 18))
                        
                    
                    Gauge(value: progress, in: 0...100) {
                        Text("Daily progress")
                            .fontWeight(.light)
                    } currentValueLabel: {
                        Text("%\(progress.formatted())")
                            //.fontWeight(.light)
                    }
                    .gaugeStyle(.accessoryLinearCapacity)
                }
                .padding(.horizontal)
                
                
                // Section-1 / No ScrollView
                VStack(alignment: .leading, spacing: 8) {
                    Text("Today's meditation")
                        .font(.title2)
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
                        .font(.title2)
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
                
                }
                .padding(.horizontal)
                
                


                
                Spacer()
                    
            }
            .onAppear {
                // MARK: Debugging purposes only for now
                navVM.changeColorPreset(colorPreset: .preset1)
            }
            .vAlign(.center)
            .hAlign(.center)
            .background(bgColor)
            //.navigationTitle("Home")
            //.navigationBarTitleDisplayMode(.inline)
            
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

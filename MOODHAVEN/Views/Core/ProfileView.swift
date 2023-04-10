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
    
    @State private var dailyReminderNotificationIsOn = true
    @State private var newMeditationNotificationIsOn = true
    @State private var goodnightNotificationIsOn = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollViewReader { mainProxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 16) {
                            GreetingHeaderTextView(text: "Profile")
                                .padding(.top, 24)

                            // MARK: Personal
                            VStack(spacing: 6) {
                                Circle().fill(fgColor.opacity(0.2).gradient)
                                    .frame(width: 90, height: 90)
                                    .padding(.bottom, 6)
                                    .overlay {
                                        Circle().stroke(fgColor, lineWidth: 1)
                                    }
                                Text("Berkay Dişli")
                                    .font(.system(size: 21))
                                
                                Text(verbatim: "berkay.dsli@gmail.com")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(uiColor: .systemGray))
                                    
                                    
                                
                                Button {
                                    
                                } label: {
                                    Text("Sign Out")
                                        .padding(.vertical, 12)
                                        .frame(maxWidth: .infinity)
                                        .background {
                                            Capsule().stroke(fgColor, lineWidth: 1)
                                                
                                            
                                        }
                                        .padding()
                                }
                            }
                            .padding(.horizontal)
                            
                            
                            Divider().padding(.horizontal)
                            
                            // MARK: Share APP
                            VStack(alignment: .leading, spacing: 10) {
                                SectionTitleView(title: "Share Moodhaven", fgColor: fgColor)
                                
                                HStack(spacing: 0) {
                                    Image("lineArtShare2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .colorInvert()
                                        .frame(width: 110)
                                    
                                    Text("Spread the joy of MoodHaven! Invite friends and family to discover the benefits of mindfulness and meditation.")
                                        .lineSpacing(4)
                                        .font(.system(size: 14))
                                        .padding()
                                        .padding(.leading, -6)
                                }
                                
                                ShareLink(item: URL(string: "https://www.instagram.com/iosdev22/")!, subject: Text("subject"), message: Text("message")) {
                                    Text("Share")
                                        .padding(.vertical, 12)
                                        .frame(maxWidth: .infinity)
                                        .background {
                                            Capsule().stroke(.purple, lineWidth: 1)
                                                
                                            
                                        }
                                        .padding()
                                }
                               
                                    
                                    
                            }
                            .padding(.horizontal)
                            
                            
                            // MARK: Notifications
                            VStack(alignment: .leading, spacing: 10) {
                                SectionTitleView(title: "Notifications", fgColor: fgColor)
                                
                                HStack(spacing: 0) {
                                    Image("lineArtBell")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .colorInvert()
                                        .frame(width: 110, height: 100)
                                        .offset(y: 5)
                                    
                                    Text("Stay up-to-date. Customize your notifications to receive reminders and updates about new meditations, features, and more.")
                                        .lineSpacing(4)
                                        .font(.system(size: 14))
                                        .padding()
                                        .padding(.leading, -6)
                                }
                                
                                VStack(spacing: 16) {
                                    Toggle(isOn: $dailyReminderNotificationIsOn) {
                                        Text("Daily Reminder")                                            .font(.system(size: 14))

                                        Text("Receive a daily reminder to help you prioritize self-care and stay centered throughout the day.")
                                            .font(.system(size: 11))

                                    }
                                    Toggle(isOn: $newMeditationNotificationIsOn) {
                                        Text("New Content")                                            .font(.system(size: 14))

                                        Text("Discover fresh content to help you focus, de-stress, and improve your well-being.")
                                            .font(.system(size: 11))
                                    }
                                    Toggle(isOn: $goodnightNotificationIsOn) {
                                        Text("Goodnight Messages")                                            .font(.system(size: 14))

                                        Text("Receive calming and uplifting messages at bedtime to help you end your day on a positive note.")
                                            .font(.system(size: 11))
                                    }
                                }
                                .tint(.purple)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 6).stroke(fgColor, lineWidth: 1)
                                }
                                .padding(.top)
                                    
                                    
                            }
                            .padding(.horizontal)
                            
                            
                            
                            ScrollUpButton(mainProxy: mainProxy)
                                .padding(.top)
                            
                            
                            
                        }
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

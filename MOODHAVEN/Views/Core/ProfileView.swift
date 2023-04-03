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
        Text("Profile View")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(fgColor: .fg0, bgColor: .set0)
    }
}

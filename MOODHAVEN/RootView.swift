//
//  RootView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 23.03.2023.
//

import SwiftUI

struct RootView: View {
    //@EnvironmentObject var navVM: NavigationViewModel
    
    var body: some View {
        TabManagerView()
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(NavigationViewModel())
    }
}

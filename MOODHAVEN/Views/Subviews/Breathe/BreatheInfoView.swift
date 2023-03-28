//
//  BreatheInfoView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct BreatheInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink("Click here") {
                    BreatheActionView()
                }
                
                Button("Dismiss") {
                    dismiss()
                }
                Spacer()
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct BreatheInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BreatheInfoView()
    }
}

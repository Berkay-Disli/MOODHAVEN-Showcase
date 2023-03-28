//
//  GreetingHeaderTextView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct GreetingHeaderTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 25))
            .fontWeight(.bold)
            .lineLimit(2)
            .hAlign(.leading)
            .padding(.horizontal)
    }
}

struct GreetingHeaderTextView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingHeaderTextView(text: "Namaste!")
    }
}

//
//  QuoteTextView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct QuoteTextView: View {
    let quote: LocalizedStringKey
    let fgColor: Color
    
    var body: some View {
        Text(quote)
            .foregroundColor(fgColor)
            .font(.system(size: 14))
            .hAlign(.leading)
            .padding(.horizontal)
    }
}

struct QuoteTextView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteTextView(quote: "If you change the way you look at things, the things you look at change. -*Wayne Dyer*", fgColor: .fg1)
    }
}

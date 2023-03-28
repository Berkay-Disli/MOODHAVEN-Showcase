//
//  SectionTitleView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct SectionTitleView: View {
    let title: String
    let fgColor: Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 18))
            .foregroundColor(fgColor)
            .hAlign(.leading)
    }
}

struct SectionTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleView(title: "ahah", fgColor: .fg1)
    }
}

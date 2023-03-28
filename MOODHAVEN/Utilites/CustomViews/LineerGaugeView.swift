//
//  LineerGaugeView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct LineerGaugeView: View {
    let progress: CGFloat
    var body: some View {
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

struct LineerGaugeView_Previews: PreviewProvider {
    static var previews: some View {
        LineerGaugeView(progress: 35.0)
    }
}

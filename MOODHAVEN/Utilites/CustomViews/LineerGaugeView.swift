//
//  LineerGaugeView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 28.03.2023.
//

import SwiftUI

struct LineerGaugeView: View {
    let progress: CGFloat
    let gaugeTitle: String
    let minValue: CGFloat
    let maxValue: CGFloat
    
    var body: some View {
        Gauge(value: progress, in: minValue...maxValue) {
            Text(gaugeTitle)
                .font(.system(size: 14))
                .fontWeight(.light)
        } currentValueLabel: {
            Text("%\(progress.formatted())")
        }
        .gaugeStyle(.accessoryLinearCapacity)
        .padding(.horizontal)
    }
}

struct LineerGaugeView_Previews: PreviewProvider {
    static var previews: some View {
        LineerGaugeView(progress: 35.0, gaugeTitle: "Ahahah", minValue: 0.0, maxValue: 0.0)
    }
}

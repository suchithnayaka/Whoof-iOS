//
//  AnalyticsView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 15/06/22.
//

import Foundation
import SwiftUI

struct AnaylticsView: View {
    
    @Binding var tabSelection: HomeView.WhoofTabs
    
    var body: some View {
        VStack {
       LineGraphView()
    }
        .background(Color.card)
        .cornerRadius(radius: 15, corners: [.topLeft,.bottomRight])
        .shadow(color: Color(hex: "#00000029"), radius: 10, x: 0, y: 10)
        .padding()
    }
}

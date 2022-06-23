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
    @ObservedObject var analyticsVM = AnalyticsViewModel()
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        FoodFillingView(progress: Float(CommonData.sharedVariables.feedingsDone)/Float(CommonData.sharedVariables.totalFeedings))
                            .frame(width: 150, height: 150)
                            .padding()
                        WaterFillingView(percent: Int(Float(CommonData.sharedVariables.feedingsDone)/Float(CommonData.sharedVariables.totalFeedings)))
                            .frame(width: 150, height: 150)
                            .padding()
                    }
                    HealthFillingView(percent: CommonData.sharedVariables.health)
                        .frame(width: 150, height: 150)
                        .padding()
                }
                Text("Temperature Tracking")
                    .foregroundColor(Color.foregroundText)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding()
                VStack {
                    if analyticsVM.temp != [] {
                        let count = analyticsVM.temp.count
                        HStack {
                        Text("\(analyticsVM.temp[count-1], specifier: "%.2f")º C")
                            .fontWeight(.bold)
                            .font(.system(size: 28))
                            .padding()
                            Spacer()
                        }
                    }
                    LineGraphView(lineColor:"#FF00006E", values: analyticsVM.temp)
                }
                .background(Color.card)
                .cornerRadius(radius: 15, corners: [.topLeft,.bottomRight])
                .shadow(color: Color(hex: "#00000029"), radius: 10, x: 0, y: 10)
                .padding()
            }
        }
        .onAppear {
            analyticsVM.getTemperature()
            analyticsVM.predictHealth()
        }
    }
}
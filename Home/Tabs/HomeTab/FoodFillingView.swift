//
//  FoodFillingView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 20/06/22.
//

import Foundation
import SwiftUI

struct FoodFillingView: View {
    var progress: Float
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Text("\(CommonData.sharedVariables.feedingsDone)/\(CommonData.sharedVariables.totalFeedings)")
                    Text("Feedings Tracked")
                        .foregroundColor(.foregroundText)
                        .font(.system(size: 12))
                }
                    .foregroundColor(.black)
                    .font(Font.system(size: 0.25 * min(geo.size.width, geo.size.height) ))
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(Color.red, lineWidth: 0.025 * min(geo.size.width, geo.size.height))
                    .opacity(0.7)
                    .foregroundColor(Color.white)
                    .rotationEffect(Angle(degrees: 270.0))
                    .frame(width: 130, height: 130)
                    .shadow(color: Color(hex: "#00000029"), radius: 10, x: 0, y: 10)
                Circle()
                    .stroke(Color.black, lineWidth: 0.05 * min(geo.size.width, geo.size.height))
                    .opacity(0.5)
            }
        }
    }
}

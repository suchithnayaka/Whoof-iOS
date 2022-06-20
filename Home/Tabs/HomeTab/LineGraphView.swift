//
//  LineGraphView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 20/06/22.
//

import Foundation
import SwiftUI

struct LineGraphView: View {
    var values: [CGFloat] = [10,12,75,65,95,12,60,50,60]
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    private var path: Path {
        if values.isEmpty {
            return Path()
        }
        var offsetX: CGFloat = CGFloat(screenWidth/CGFloat(values.count))
        var path = Path()
        path.move(to: CGPoint(x: 0, y: values[0]))
        
        for value in values {
            offsetX += (screenWidth/CGFloat(values.count))
            path.addLine(to: CGPoint(x: offsetX, y: value))
            
        }
        return path
    }
    
    var body: some View {
        VStack {
            path.stroke(Color(hex: "#FF00006E"), lineWidth: 2)
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .frame(maxWidth: .infinity, maxHeight: 300)
        }
        .frame(height: 300)
    }
}

//
//  HeartView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 21/06/22.
//

import Foundation
import SwiftUI

struct HeartView: Shape {
    public func path(in rect: CGRect) -> Path{
        var path = Path()
            path.move(to: CGPoint(x: 100, y:50))
            path.addCurve(to: CGPoint(x: 100, y: 185), control1: CGPoint(x: 190,y:10), control2: CGPoint(x:190,y: 150))
            path.addCurve(to: CGPoint(x: 100, y: 50), control1: CGPoint(x: -5, y:120), control2: CGPoint(x: 15, y: 30))
            return path
        }
       
}

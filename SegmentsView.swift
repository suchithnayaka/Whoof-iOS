//
//  SegmentsView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 11/06/22.
//CustomProgressView.swift

import Foundation
import SwiftUI

struct SegmentsView: View {
    @Binding var selectedIndex: Int
    var segments: [String]
    var body: some View {
        HStack {
            ForEach(segments, id: \.self) {segment in
                Button {
                    selectedIndex = segments.firstIndex(of: segment) ?? 0
                } label: {
                    Text(segment)
                        .font(Font.system(size: 16))
                        .scaledToFill()
                        .minimumScaleFactor(0.1)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .frame(width: 100)
                .background(selectedIndex == segments.firstIndex(of: segment) ? Color(hex: "#D47FA6") : Color(hex: "#8A56AC"))
                .clipShape(Capsule())
            }
        }
        .foregroundColor(.white)
        .background(Color(hex: "#8A56AC"))
        .clipShape(Capsule())
        .frame(maxWidth: UIScreen.main.bounds.width/1.1)
    }
}

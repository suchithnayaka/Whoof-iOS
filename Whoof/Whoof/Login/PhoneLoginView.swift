//
//  PhoneLoginView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 11/06/22.
//

import Foundation
import SwiftUI

struct PhoneLoginView: View {
    var body: some View {
        VStack {
            ZStack {
                Color.white
                    .frame(height: 200)
                    .cornerRadius(radius: 100, corners: [.bottomLeft])
                VStack {
                    HStack{
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                        Spacer()
                    }
                    Text("Phone Number")
                        .fontWeight(.bold)
                        .font(.system(size: 26))
                        .foregroundColor(.black)
                }
            }
        }
        .background(Color(hex: "#241332").ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

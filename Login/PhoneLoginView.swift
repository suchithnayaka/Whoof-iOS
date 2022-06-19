//
//  PhoneLoginView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 11/06/22.
//

import Foundation
import SwiftUI

struct PhoneLoginView: View {
    
    @State private var string = "0"
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        ZStack {
            Color(hex: "#241332")
                .ignoresSafeArea()
            VStack {
                ZStack {
                    Color.white
                        .frame(height: 150)
                        .cornerRadius(radius: 100, corners: [.bottomLeft])
                    VStack {
                        HStack{
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.black)
                                    .padding()
                            }
                            Spacer()
                        }
                        Text("Phone Number")
                            .fontWeight(.bold)
                            .font(.system(size: 26))
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                HStack {
                    Image("flag")
                    Image(systemName: "chevron.down")
                    Text(string)
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                    Spacer()
                }
                .padding()
                Divider()
                    .padding()
                NavigationLink {
                    VerifyOTPView()
                } label: {
                    Text("Verify")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .textCase(.uppercase)
                        .padding()
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .background(Color(hex: "#8A56AC"))
                .cornerRadius(40)
                .padding()
                KeyPad(string: $string)
                    .padding(.vertical)
            }
        }
        .navigationBarHidden(true)
    }
}

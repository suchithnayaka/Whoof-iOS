//
//  LoginView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 31/05/22.
//

import Foundation
import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            Image("Dog")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.vertical)
            VStack {
                Text("Welcome\nto Whoof!")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                Text("The best way to take good care of your pet. Let's get started!")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .padding()
                Text("Continue with:")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .textCase(.uppercase)
                    .opacity(0.6)
                    .padding()
                NavigationLink {
                    PhoneLoginView()
                        .edgesIgnoringSafeArea(.bottom)
                } label: {
                    Text("Phone Number")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .textCase(.uppercase)
                        .padding()
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .background(Color(hex: "#8A56AC"))
                .cornerRadius(40)
                NavigationLink {
                   OnboardingView()
                } label: {
                    Text("Email")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .textCase(.uppercase)
                        .padding()
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .background(Color(hex: "#D47FA6"))
                .cornerRadius(40)
            }
        }
    }
}

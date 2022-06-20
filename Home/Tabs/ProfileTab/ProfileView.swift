//
//  ProfileView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 15/06/22.
//

import Foundation
import SwiftUI

class MoreOptionsModel: Identifiable {
    let id = UUID()
    var image: Image
    var title: String
    var type: OptionType
    
    init(type: OptionType) {
        self.type = type
        self.image = type.image()
        self.title = type.rawValue
    }
}
enum OptionType: String, CaseIterable {
    case preferences = "Preferences"
    case share = "Share"
    case support = "Support"
    case contacts = "Contacts"
    
    func localizedString() -> String {
        switch self {
        case .preferences:
            return NSLocalizedString("Preferences", comment: "")
        case .share:
            return NSLocalizedString("Share", comment: "")
        case .support:
            return NSLocalizedString("Support", comment: "")
        case .contacts:
            return NSLocalizedString("Allow access to my contacts", comment: "")
        }
    }
    
    func image() -> Image {
        switch self {
        case .preferences:
            return Image(systemName: "gearshape.fill")
        case .share:
            return Image(systemName: "square.and.arrow.up")
        case .support:
            return Image(systemName: "headphones")
        case .contacts:
            return Image(systemName: "lock")
        }
    }
}


struct ProfileView: View {
    
    @Binding var tabSelection: HomeView.WhoofTabs
    @State var logoutAlert: Bool = false
    @State var gotoPreferences: Bool = false
    @State var options: [MoreOptionsModel] = [MoreOptionsModel(type: .preferences), MoreOptionsModel(type: .share), MoreOptionsModel(type: .support), MoreOptionsModel(type: .contacts)]
    @ObservedObject var profileVM = ProfileViewModel()
    @EnvironmentObject var userAuth: UserAuth
    
    
    
    var body: some View {
        ZStack {
            Color.bgColor
            VStack {
                NavigationLink(isActive: $gotoPreferences) {
                        PreferencesView()
                } label: {
                    EmptyView()
                }
                VStack {
                    ForEach(options) { option in
                        MoreOptionsCell(option: option)
                            .padding()
                            .onTapGesture {
                                switch option.type {
                                case .preferences:
                                    gotoPreferences = true
                                    break
                                    
                                case .contacts:
                                    print("Contacts")
                                    
                                case .share:
                                    print("share")
                                    
                                case .support:
                                    print("support")
                                }
                            }
                    }
                }
                .background(Color.card)
                .cornerRadius(8)
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    options.removeAll()
                    for each in OptionType.allCases {
                        options.append(MoreOptionsModel(type: each))
                    }
                }
                .alert(isPresented: $logoutAlert) {
                    Alert(title: Text(LocalizedStringKey("Logout")), message: Text(LocalizedStringKey("Are you sure you want to log out?")), primaryButton: .default(Text(LocalizedStringKey("Yes")), action: {
                        userAuth.logout()
                    }), secondaryButton: .default(Text(LocalizedStringKey("No")).foregroundColor(Color.red), action: {
                        logoutAlert = false
                    }))
                }
                Button {
                    logoutAlert = true
                } label: {
                        Text("Logout")
                            .foregroundColor(.tabSelected)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .opacity(0.6)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .padding(.horizontal)
                            .textCase(.uppercase)
                            .overlay(RoundedRectangle(cornerRadius: 100)
                                .stroke(Color(hex: "#C8D1D3"), lineWidth: 1))
                }
                .padding(.vertical)
                .padding(.leading)
                .shadow(color: Color(hex: "#00000029"), radius: 10, x: 0, y: 10)
            }
        }
    }
}

struct MoreOptionsCell: View {
    @State var accessGranted: Bool = true
    var option: MoreOptionsModel
    var body: some View {
        HStack(spacing: 8) {
            option.image
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 25)
                .foregroundColor(Color.black)
            Text(option.type.localizedString())
                .foregroundColor(.foregroundText)
            Spacer()
            if option.title == "Contacts" {
                Toggle(isOn: $accessGranted) {
                    
                }
            }
            else {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(hex: "#C8D1D3"))
            }
        }
        .font(.system(size: 20, weight: .regular))
    }
}



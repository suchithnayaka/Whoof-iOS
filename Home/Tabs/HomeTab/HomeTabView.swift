//
//  HomeTabView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 15/06/22.
//

import Foundation
import SwiftUI

struct HomeTabView: View {
    @State var showAlert: Bool = false
    @Binding var tabSelection: HomeView.WhoofTabs
    @ObservedObject var homeTabVM = HomeTabViewModel()
    @ObservedObject var analyticsVM = AnalyticsViewModel()
    var body: some View {
        ZStack {
            Color.bgColor
            VStack {
                HStack {
                    Text("Heart Rate Monitoring")
                        .foregroundColor(Color.foregroundText)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding()
                    Spacer()
                }
                VStack {
                    if homeTabVM.heartRates != [] {
                        let count = homeTabVM.heartRates.count
                        HStack {
                            Text("\(homeTabVM.heartRates[count-1], specifier: "%.2f") bpm")
                                .fontWeight(.bold)
                                .font(.system(size: 28))
                                .padding()
                            Spacer()
                        }
                        if let lastHeart = Int(homeTabVM.heartRates[count-1]) {
                            HStack {
                            if lastHeart > homeTabVM.heartHigh {
                                let difference = lastHeart - homeTabVM.heartHigh
                                Image(systemName: "arrow.up")
                                    .foregroundColor(.red)
                                    .font(.system(size: 16))
                                    .padding([.vertical,.leading])
                                Text("\((Float(difference)/Float(homeTabVM.heartHigh))*100, specifier: "%.2f")% Higher than optimal Heart Rate")
                                    .foregroundColor(.red)
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                            }
                            else if lastHeart < homeTabVM.heartLow {
                                let difference = homeTabVM.heartLow - lastHeart
                                Image(systemName: "arrow.down")
                                    .foregroundColor(.red)
                                    .font(.system(size: 16))
                                    .padding([.vertical,.leading])
                                Text("\((Float(difference)/Float(homeTabVM.heartLow))*100, specifier: "%.2f")% Lower than optimal Heart Rate")
                                    .foregroundColor(.red)
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                            }
                                Spacer()
                            }
                        }
                    }
                    LineGraphView(lineColor: "#5F4591" , values: homeTabVM.heartRates)
                }
                .background(Color.card)
                .cornerRadius(radius: 15, corners: [.topLeft,.bottomRight])
                .shadow(color: Color(hex: "#00000029"), radius: 10, x: 0, y: 10)
                .padding()
                
                HStack {
                    Button {
                        if homeTabVM.feedingsDone < CommonData.sharedVariables.totalFeedings {
                            homeTabVM.feedFood()
                        }
                        else {
                            CommonData.sharedVariables.feedingsDone = 0
                            showAlert = true
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Feed your\n Dog!")
                                .foregroundColor(.tabSelected)
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding()
                            HStack {
                                MyProgressView(progress: Float(homeTabVM.feedingsDone)/Float(CommonData.sharedVariables.totalFeedings))
                                    .frame(width: 20, height: 20)
                                    .padding([.vertical,.leading])
                                Text("\(homeTabVM.feedingsDone)/\(CommonData.sharedVariables.totalFeedings) times done")
                                    .foregroundColor(.tabSelected)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .opacity(0.5)
                                    .padding()
                            }
                        }
                        .background(Color(hex: "#9599B3"))
                        .cornerRadius(radius: 10, corners: [.topLeft,.bottomRight])
                        .cornerRadius(radius: 40, corners: [.topRight,.bottomLeft])
                    }
                    .padding(.vertical)
                    .padding(.leading)
                    .shadow(color: Color(hex: "#00000029"), radius: 10, x: 0, y: 10)
                    Button {
                        
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Feed some\n Water")
                                .foregroundColor(.tabSelected)
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding()
                            HStack {
                                MyProgressView(progress: Float(homeTabVM.feedingsDone)/Float(CommonData.sharedVariables.totalFeedings))
                                    .frame(width: 20, height: 20)
                                    .padding([.vertical,.leading])
                                Text("\(homeTabVM.feedingsDone)/\(CommonData.sharedVariables.totalFeedings) times done")
                                    .foregroundColor(.tabSelected)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .opacity(0.5)
                                    .padding()
                            }
                        }
                        .background(Color(hex: "#8A56AC"))
                        .cornerRadius(radius: 10, corners: [.topLeft,.bottomRight])
                        .cornerRadius(radius: 40, corners: [.topRight,.bottomLeft])
                    }
                    .padding(.vertical)
                    .padding(.trailing)
                    .shadow(color: Color(hex: "#00000029"), radius: 10, x: 0, y: 10)
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text("Your dog had enough food for the day."), dismissButton: .default(Text("OK")))
        })
        .onAppear {
            analyticsVM.getTemperature()
            homeTabVM.getIPfromFirebase()
            homeTabVM.getPulse()
            homeTabVM.getOptimal()
        }
    }
}

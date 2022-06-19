//
//  HomeTabModel.swift
//  Whoof
//
//  Created by Suchith Nayaka on 15/06/22.
//

import Foundation
import SwiftUI


struct FeedNetworkResponseModel: Codable {
    var status: String
    var ip: String
}

struct PredictHealthPostModel: Codable {
    var breed: Int
    var temp: Float
    var age: Int
    var heartRate: Int
    var weight: Int
    var gender: Int
    var food: Int
    var water: Int
}

struct PredictHealthResponseModel: Codable {
    var prediction: String
    var risk: Float
}

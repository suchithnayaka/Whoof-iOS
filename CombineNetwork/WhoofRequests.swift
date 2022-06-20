//
//  WhoofRequests.swift
//  Whoof
//
//  Created by Suchith Nayaka on 13/06/22.
//

import Foundation
import Combine
import UIKit
import SwiftUI
import FirebaseDatabase

public typealias Headers = [String: String]

// if you wish you can have multiple services like this in a project
enum WhoofEndpoints {
    
    case feedFood
    case feedWater
    case predictHealth(data: PredictHealthPostModel)
    
    //specify the type of HTTP request
    
    var httpMethod: HTTPMethod {
        switch self {
        case .feedFood,.feedWater:
            return .GET
        case .predictHealth:
            return .POST
        }
    }
    
    // compose the NetworkRequest
    func createRequest(token: String = "", environment: NetworkEnvironment) -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        //        headers["Authorization"] = "Bearer \(token)"
        return NetworkRequest(url: getURL(from: environment), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .feedFood:
            return nil
        case .feedWater:
            return nil
        case .predictHealth(let data):
            return data
        }
    }
    // compose urls for each request
    func getURL(from environment: NetworkEnvironment) -> String {
        let baseUrl = environment.whoofServiceBaseURL
        switch self {
        case .feedFood:
            return "https://\(CommonData.sharedVariables.feederIP)/feedFood"
        case .feedWater:
            return "https://\(CommonData.sharedVariables.feederIP)/feedWater"
        case .predictHealth:
            return "\(baseUrl)/predict"
            
        }
    }
    
}

public enum NetworkEnvironment: String, CaseIterable {
    case development
    case staging
    case production
}

extension NetworkEnvironment {
    var whoofServiceBaseURL: String {
        switch self {
        case .development:
            return "https://whoof-petcare.herokuapp.com"
        case .staging:
            return "https://whoof-petcare.herokuapp.com"
        case .production:
            return "https://whoof-petcare.herokuapp.com"
        }
    }
}


protocol WhoofServiceable {
    
    func feedFood() -> AnyPublisher<FeedNetworkResponseModel, NetworkRequestError>
    func feedWater() -> AnyPublisher<FeedNetworkResponseModel, NetworkRequestError>
    func predictHealth(data: PredictHealthPostModel) -> AnyPublisher<PredictHealthResponseModel, NetworkRequestError>
    
}

class WhoofService: WhoofServiceable {
    
    func feedFood() -> AnyPublisher<FeedNetworkResponseModel, NetworkRequestError> {
        let endpoint = WhoofEndpoints.feedFood
        let request = endpoint.createRequest(environment: self.environment)
        return self.networkRequest.request(request)
    }
    
    func feedWater() -> AnyPublisher<FeedNetworkResponseModel, NetworkRequestError> {
        let endpoint = WhoofEndpoints.feedWater
        let request = endpoint.createRequest(environment: self.environment)
        return self.networkRequest.request(request)
    }
    
    func predictHealth(data: PredictHealthPostModel) -> AnyPublisher<PredictHealthResponseModel, NetworkRequestError> {
        let endpoint = WhoofEndpoints.predictHealth(data: data)
        let request = endpoint.createRequest(environment: self.environment)
        return self.networkRequest.request(request)
    }
    
    
    private var networkRequest: Requestable
    private var environment: NetworkEnvironment = .production
    
    convenience init() {
        self.init(networkRequest: NativeRequestable(), environment: .production)
    }
    // inject this for testability
    init(networkRequest: Requestable, environment: NetworkEnvironment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
}


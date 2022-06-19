//
//  HomeTabViewModel.swift
//  Whoof
//
//  Created by Suchith Nayaka on 15/06/22.
//

import Foundation
import Combine

class HomeTabViewModel: ObservableObject {
    
    var subscriptions = Set<AnyCancellable>()
    let service = WhoofService()
    
    func feedFood() {
        service.feedFood()
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Feeding Done")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { response in
                print(response)
            }.store(in: &subscriptions)
    }
    
    func feedWater() {
        service.feedWater()
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Feeding Done")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { response in
                print(response)
            }
            .store(in: &subscriptions)
    }
    
    func predictHealth() {
        service.predictHealth(data: PredictHealthPostModel(breed: 0, temp: 37.22, age: 1, heartRate: 102, weight: 26, gender: 1, food: 1, water: 1050))
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Fetching Done")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { response in
                print(response)
            }
            .store(in: &subscriptions)
    }
}

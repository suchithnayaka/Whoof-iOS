//
//  HomeTabViewModel.swift
//  Whoof
//
//  Created by Suchith Nayaka on 15/06/22.
//

import Foundation
import Combine
import FirebaseDatabase

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
        service.predictHealth(data: PredictHealthPostModel(breed: CommonData.sharedVariables.breed, temp: 37.22, age: CommonData.sharedVariables.age, heartRate: 102, weight: CommonData.sharedVariables.weight, gender: CommonData.sharedVariables.gender, food: 1, water: 1050))
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
    
    
    func getIPfromFirebase() {
        let ref = Database.database().reference()
        var result = ""
        ref.child("suchith/ip").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                if snapshot.value != nil {
                    result = snapshot.value as! String
                    CommonData.sharedVariables.feederIP = result
                }
            }
            else {
                print("No data available")
            }
        }
    }
}

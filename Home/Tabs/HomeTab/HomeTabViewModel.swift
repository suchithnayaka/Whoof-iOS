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
    
    @Published var heartRates: [CGFloat] = []
    @Published var feedingsDone: Int = CommonData.sharedVariables.feedingsDone
    @Published var heartHigh: Int = 0
    @Published var heartLow: Int = 0
    var subscriptions = Set<AnyCancellable>()
    let service = WhoofService()
    
    func feedFood() {
        service.feedFood()
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Feeding Done")
                    self.feedingsDone += 1
                    CommonData.sharedVariables.feedingsDone += 1
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
        service.predictHealth(data: PredictHealthPostModel(breed: CommonData.sharedVariables.breed, temp: CommonData.sharedVariables.temp, age: CommonData.sharedVariables.age, heartRate: CommonData.sharedVariables.heart, weight: CommonData.sharedVariables.weight, gender: CommonData.sharedVariables.gender, food: CommonData.sharedVariables.feedingsDone, water: 1050))
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Prediction Done")
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
    
    func getPulse(){
        let ref = Database.database().reference()
        ref.child("suchith/heart").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            self.heartRates = value?.allValues as! [CGFloat]
            print(self.heartRates)
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    func getOptimal() {
        let ref = Database.database().reference()
        ref.child("optimal/German Shepherd/Male/Puppy/heart/high").observeSingleEvent(of: .value, with: { snapshot in
            self.heartHigh = snapshot.value as? Int ?? 0
            print(self.heartHigh)
        }) { error in
            print(error.localizedDescription)
        }
        ref.child("optimal/German Shepherd/Male/Puppy/heart/low").observeSingleEvent(of: .value, with: { snapshot in
            self.heartLow = snapshot.value as? Int ?? 0
            print(self.heartLow)
        }) { error in
            print(error.localizedDescription)
        }
    }
    
}

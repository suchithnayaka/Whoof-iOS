//
//  AnalyticsViewModel.swift
//  Whoof
//
//  Created by Suchith Nayaka on 23/06/22.
//

import Foundation
import Combine
import FirebaseDatabase

class AnalyticsViewModel: ObservableObject {
    
    @Published var tempHigh: Int = 0
    @Published var temptLow: Int = 0
    @Published var temp: [CGFloat] = []
    var subscriptions = Set<AnyCancellable>()
    let service = WhoofService()
    
    func getTemperature() {
        let ref = Database.database().reference()
        ref.child("suchith/temp").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            self.temp = value?.allValues as! [CGFloat]
            print(self.temp)
        }) { error in
            print(error.localizedDescription)
        }
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
                CommonData.sharedVariables.health = Int(100.0 - response.risk)
            }
            .store(in: &subscriptions)
    }
    
    func getOptimal() {
        let ref = Database.database().reference()
        ref.child("optimal/German Shepherd/Male/Puppy/temp/high").observeSingleEvent(of: .value, with: { snapshot in
            self.tempHigh = snapshot.value as? Int ?? 0
            print(self.tempHigh)
        }) { error in
            print(error.localizedDescription)
        }
        ref.child("optimal/German Shepherd/Male/Puppy/temp/low").observeSingleEvent(of: .value, with: { snapshot in
            self.temptLow = snapshot.value as? Int ?? 37
            print(self.temptLow)
        }) { error in
            print(error.localizedDescription)
        }
    }

}

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
    
    @Published var temp: [CGFloat] = []
    var subscriptions = Set<AnyCancellable>()
    let service = WhoofService()
    
    func getTemperature() {
        let ref = Database.database().reference()
        ref.child("suchith/temp").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                if snapshot.value != nil {
                    self.temp = snapshot.value as! [CGFloat]
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if self.temp != [] {
                            CommonData.sharedVariables.temp = Float(self.temp.last!)
                        }
                    }
                }
            }
            else {
                print("No data available")
            }
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

}

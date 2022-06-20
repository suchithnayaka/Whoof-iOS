//
//  PreferencesView.swift
//  Whoof
//
//  Created by Suchith Nayaka on 19/06/22.
//

import Foundation
import SwiftUI

struct PreferencesView: View {
    @State var weight: Int = 0
    @State var breed: Int = 0
    @State var gender: Int = 0
    @State var age: Int = 0
    @State var genderOptions: [String] = ["Male","Female"]
    @State var breedOptions: [String] = ["German Shepherd", "Golden Retriever"]
    @State var ageOptions: [String] = ["Puppy","Adult","Old"]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Breed of the Dog")
                    Picker("",selection: $breed) {
                        ForEach(0 ..< breedOptions.count) {
                            Text(self.breedOptions[$0])
                        }
                    }
                }
                Section {
                    Text("Age of the Dog")
                    Picker("",selection: $age) {
                        ForEach(0 ..< ageOptions.count) {
                            Text(self.ageOptions[$0])
                        }
                    }
                }
                Section {
                    Text("Gender of the Dog")
                    Picker("",selection: $gender) {
                        ForEach(0 ..< genderOptions.count) {
                            Text(self.genderOptions[$0])
                        }
                    }
                }
                Section {
                    Text("Weight of the dog(In Kgs)")
                    Picker("",selection: $weight) {
                        ForEach(0..<100) {
                            Text("\($0)")
                        }
                    }
                }
            }
        }
        .onDisappear {
            CommonData.sharedVariables.gender = gender
            CommonData.sharedVariables.age = age
            CommonData.sharedVariables.breed = breed
            CommonData.sharedVariables.weight = weight
        }
    }
}

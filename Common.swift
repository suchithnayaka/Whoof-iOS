//
//  Common.swift
//  Whoof
//
//  Created by Suchith Nayaka on 15/06/22.
//

import Foundation
import Combine


class CommonData {
    static var sharedVariables = SharedVariables()
}
class SharedVariables: ObservableObject {
    var isLoggedIn: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "isLoggedIn")
        } get {
            return UserDefaults.standard.bool(forKey: "isLoggedIn") 
        }
    }
    
    var gender: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "gender")
        } get {
            return Int(UserDefaults.standard.integer(forKey: "gender"))
        }
    }
    
    var age: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "age")
        } get {
            return Int(UserDefaults.standard.integer(forKey: "age"))
        }
    }
    
    var weight: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "weight")
        } get {
            return Int(UserDefaults.standard.integer(forKey: "weight"))
        }
    }
    
    var heart: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "heart")
        } get {
            return Int(UserDefaults.standard.integer(forKey: "heart"))
        }
    }
    
    var temp: Float {
        set {
            UserDefaults.standard.set(newValue, forKey: "temp")
        } get {
            return Float(UserDefaults.standard.integer(forKey: "temp"))
        }
    }
    
    var breed: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "breed")
        } get {
            return Int(UserDefaults.standard.integer(forKey: "breed"))
        }
    }
    
    var totalFeedings: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "totalFeedings")
        } get {
            return Int(UserDefaults.standard.integer(forKey: "totalFeedings"))
        }
    }
    
    var feedingsDone: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "feedingsDone")
        } get {
            return Int(UserDefaults.standard.integer(forKey: "feedingsDone"))
        }
    }
    
    var feederIP: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "feederIP")
        } get {
            return UserDefaults.standard.string(forKey: "feederIP") ?? ""
        }
    }
    
    var health: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "health")
        } get {
            return Int(UserDefaults.standard.integer(forKey: "health"))
        }
    }
}

//
//  Common.swift
//  Whoof
//
//  Created by Suchith Nayaka on 15/06/22.
//

import Foundation


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
    
    var breed: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "breed")
        } get {
            return Int(UserDefaults.standard.integer(forKey: "breed"))
        }
    }
    
    var feederIP: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "feederIP")
        } get {
            return UserDefaults.standard.string(forKey: "feederIP") ?? ""
        }
    }
}

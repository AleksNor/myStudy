//
//  ViewModel.swift
//  MVVM1
//
//  Created by Евгений Карпов on 10.12.2021.
//

import Foundation

class ViewModel {
    
    private var profile = Profile(name: "John", secondName: "Smith", age: 33)
    
    var name: String {
        return profile.name
    }
    var secondName: String {
        return profile.secondName
    }
    var age: String {
        return String(describing: profile.age)
    }
}

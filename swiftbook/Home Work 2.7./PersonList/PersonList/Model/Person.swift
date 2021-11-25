//
//  Person.swift
//  PersonList
//
//  Created by Евгений Карпов on 25.11.2021.
//

import Foundation

struct Person {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    
    func getWholeName() -> String {
        return "\(firstName) \(lastName)"
    }
}

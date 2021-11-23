//
//  Person.swift
//  LoginApp
//
//  Created by Евгений Карпов on 23.11.2021.
//

import Foundation

struct User {
    var login: String
    var password: String
    var person: Person
}

struct Person {
    var firstName: String
    var lastName: String
    
    func getWholeName() -> String {
        return "\(firstName) \(lastName)"
    }
}

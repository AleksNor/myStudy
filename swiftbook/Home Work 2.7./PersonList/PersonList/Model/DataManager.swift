//
//  DataManager.swift
//  PersonList
//
//  Created by Евгений Карпов on 25.11.2021.
//

import Foundation

protocol DataManagerProtocol {
    var firstNameArray: [String] {get}
    var lastNameArray: [String] {get}
    var emailArray: [String] {get}
    var phoneNumberArray: [String] {get}
    
    func addAllPerson() -> [Person]
}

extension DataManagerProtocol {
    func addAllPerson() -> [Person] {
        
        var resultArray: [Person] = []
        
        let personCount: Int = firstNameArray.count
        
        //Creating random array for each of Person properties
        let randomNumForFirstName: [Int] = Array.generateRandom(size: personCount)
        let randomNumForLastName: [Int] = Array.generateRandom(size: personCount)
        let randomNumForEmail: [Int] = Array.generateRandom(size: personCount)
        let randomNumForPhoneNumber: [Int] = Array.generateRandom(size: personCount)
        
        for index in (0...personCount - 1) {
            resultArray.append(Person(
                firstName:
                    firstNameArray[randomNumForFirstName[index]],
                lastName:
                    lastNameArray[randomNumForLastName[index]],
                email:
                    emailArray[randomNumForEmail[index]],
                phoneNumber:
                    phoneNumberArray[randomNumForPhoneNumber[index]]))
        }
        
        return resultArray
    }
}

class DataManager: DataManagerProtocol {
    var firstNameArray: [String] = ["John", "Dart", "Robert", "Shiro", "Kaney"]
    var lastNameArray: [String] = ["Cena", "Weider", "Patison", "Style", "West"]
    var emailArray: [String] = ["thisisjohncena@me.com", "theemperor@allworld.com", "justguy@newermind.com", "hellyeah@yandex.ru", "iamrap@eminem.ru"]
    var phoneNumberArray: [String] = ["+13-909-123-12-12", "+7-902-543-11-23", "+123-444-55-66", "+6-999-222-65-32", "+8-011-212-12-12"]
}

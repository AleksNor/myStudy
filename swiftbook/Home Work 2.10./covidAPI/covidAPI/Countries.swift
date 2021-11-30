//
//  Countries.swift
//  covidAPI
//
//  Created by Евгений Карпов on 29.11.2021.
//

import Foundation

struct Countries: Decodable {
    var countries: [Country]
    
    func getAllName() -> [String] {
        var result: [String] = []
        for country in countries {
            result.append(country.name)
        }
        return result
    }
}

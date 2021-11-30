//
//  Country.swift
//  covidAPI
//
//  Created by Евгений Карпов on 29.11.2021.
//

import Foundation

struct preCountry: Decodable{
    var All: Country
}

struct Country: Decodable {
    var name: String
    var iso2: String?
}

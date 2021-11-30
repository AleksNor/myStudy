//
//  CountryDetail.swift
//  covidAPI
//
//  Created by Евгений Карпов on 30.11.2021.
//

import Foundation


struct CountryDetail: Decodable {
    var confirmed: ContryDetailInfo
    var deaths: ContryDetailInfo
}


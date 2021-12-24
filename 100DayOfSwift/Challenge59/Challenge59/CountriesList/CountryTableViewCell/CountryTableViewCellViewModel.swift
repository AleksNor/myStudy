//
//  CountryTableViewCellViewModel.swift
//  Challenge59
//
//  Created by Евгений Карпов on 24.12.2021.
//

import Foundation

protocol CountryTableViewCellViewModelProtocol {
    var countryCommonName: String { get }
    var countryOfficalName: String { get }
    init (country: Country)
}

class CountryTableViewCellViewModel: CountryTableViewCellViewModelProtocol {
    private let country: Country
    
    var countryCommonName: String {
        country.name.common
    }
    
    var countryOfficalName: String {
        country.name.official
    }
    
    required init(country: Country) {
        self.country = country
    }
    
    
}

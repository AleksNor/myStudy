//
//  CountryDetailTableViewCellModel.swift
//  Challenge59
//
//  Created by Евгений Карпов on 24.12.2021.
//

import Foundation

protocol CountryDetailTableViewCellViewModelProtocol {
    init(at indexPath: IndexPath, country: Country)
    var labelText: String { get }
}

class CountryDetailTableViewCellViewModel: CountryDetailTableViewCellViewModelProtocol {
    private let country: Country
    private let indexPath: IndexPath
    
    required init(at indexPath: IndexPath, country: Country) {
        self.country = country
        self.indexPath = indexPath
    }
    
    var labelText: String {
        switch indexPath.row {
        case 0:
            return "Country region: \(country.region)"
        case 1:
            return "Country subregion: \(country.subregion)"
        case 2:
            var result: String = ""
            country.capital.forEach {
                result.append(" \($0)")
            }
            return "Country capital:\(result)"
        case 3:
            return "Country population: \(country.population)"
        case 4:
            var result: String = ""
            country.timezones.forEach {
                result.append(" \($0)")
            }
            return "Country TimeZones:\(result)"
        default:
            return "Unknow indexPath"
        }
    }

    
    
    
}

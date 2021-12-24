//
//  CountryDetailsViewModel.swift
//  Challenge59
//
//  Created by Евгений Карпов on 24.12.2021.
//

import Foundation

protocol CountryDetailsViewModelProtocol {
    var flagImage: Data? { get }
    var countryName: String { get }
    init(country: Country)
    func numberOfRows() -> Int
    func cellForRow(at indexPath: IndexPath) -> CountryDetailTableViewCellViewModelProtocol
}

class CountryDetailsViewModel: CountryDetailsViewModelProtocol {
    private let country: Country
    
    var flagImage: Data? {
        ImageManager.shared.fetchImage(from: country.flags.png)
    }
    
    var countryName: String {
        country.name.official
    }
    
    required init(country: Country) {
        self.country = country
    }
    
    func numberOfRows() -> Int {
        return 5
    }
    
    func cellForRow(at indexPath: IndexPath) -> CountryDetailTableViewCellViewModelProtocol {
        return CountryDetailTableViewCellViewModel(at: indexPath, country: country)
    }
}

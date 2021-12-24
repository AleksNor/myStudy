//
//  CountriesListViewModel.swift
//  Challenge59
//
//  Created by Евгений Карпов on 24.12.2021.
//

import Foundation

protocol CountriesListViewModelProtocol {
    var countries: Countries { get }
    func fetchData(complition: @escaping () -> Void)
    func numberOfRows() -> Int
    func cellForRow(at indexPath: IndexPath) -> CountryTableViewCellViewModelProtocol
    func viewModelForSelectedRow(at indexPath: IndexPath) -> CountryDetailsViewModelProtocol
}

class CountriesListViewModel: CountriesListViewModelProtocol {
    var countries: Countries = []
    
    func fetchData(complition: @escaping () -> Void) {
        NetworkManager.shared.fetchData { countries in
            self.countries = countries
            self.countries.sort { $0.name.common < $1.name.common}
            complition()
        }
    }
    
    func numberOfRows() -> Int {
        return countries.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> CountryTableViewCellViewModelProtocol {
        let country = countries[indexPath.row]
        return CountryTableViewCellViewModel(country: country)
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> CountryDetailsViewModelProtocol {
        let country = countries[indexPath.row]
        return CountryDetailsViewModel(country: country)
    }
    
    
}

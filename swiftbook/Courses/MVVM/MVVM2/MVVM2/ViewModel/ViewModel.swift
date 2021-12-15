//
//  ViewModel.swift
//  MVVM2
//
//  Created by Евгений Карпов on 10.12.2021.
//

import Foundation

class ViewModel: TableViewViewModelType {
    var profiles = [
        Profile(name: "John", secondName: "Smith", age: 33),
        Profile(name: "max", secondName: "Kolby", age: 21),
        Profile(name: "Mark", secondName: "salmon", age: 55)]
    
    func numberOfRows() -> Int {
        return profiles.count
    }
    
    func cellNewViewModel(forIndexPath IndexPath: IndexPath) -> TableViewCellViewModelType? {
        let profile = profiles[IndexPath.row]
        
        return TableViewCellViewModelType(profile: profile)
    }
}

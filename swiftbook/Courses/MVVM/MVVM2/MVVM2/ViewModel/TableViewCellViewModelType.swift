//
//  TableViewCellViewModel.swift
//  MVVM2
//
//  Created by Евгений Карпов on 10.12.2021.
//

import Foundation

class TableViewCellViewModelType: TableViewCellModelType {
    
    private var profile: Profile
    
    var fullName: String {
        return profile.name + " " + profile.secondName
    }
    
    var age: String {
        return String(describing: profile.age)
    }
    
    init(profile: Profile) {
        self.profile = profile
    }
    
}

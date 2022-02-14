//
//  DataModel.swift
//  UnitTestingApp
//
//  Created by Евгений Карпов on 07.12.2021.
//

import Foundation

class DataModel {
    private(set) var volume = 0
    
    func setVolume(to value: Int) {
        volume = min((max(value, 0)), 100)
    }
    
    func greaterThenVaule(x: Int, y: Int) -> Bool {
        x > y
    }
}

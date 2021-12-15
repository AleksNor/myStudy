//
//  TableViewCellModelType.swift
//  MVVM2
//
//  Created by Евгений Карпов on 10.12.2021.
//

import Foundation

protocol TableViewCellModelType: AnyObject {
    var fullName: String {get}
    var age: String {get}
}

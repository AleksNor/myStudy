//
//  DetailViewModelType.swift
//  MVVM2
//
//  Created by Евгений Карпов on 15.12.2021.
//

import Foundation

protocol DetailViewModelType {
    var desciption: String { get }
    var age: Box<String?> { get }
}

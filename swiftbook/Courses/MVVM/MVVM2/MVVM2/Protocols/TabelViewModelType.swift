//
//  TabelViewModelType.swift
//  MVVM2
//
//  Created by Евгений Карпов on 10.12.2021.
//

import Foundation

protocol TableViewViewModelType {
    func numberOfRows() -> Int
    func cellNewViewModel(forIndexPath IndexPath: IndexPath) -> TableViewCellViewModelType?
}

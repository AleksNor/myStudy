//
//  TableViewCell.swift
//  MVVM2
//
//  Created by Евгений Карпов on 10.12.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else {
                return
            }
            fullNameLabel.text = viewModel.fullName
            ageLabel.text = viewModel.age
        }
    }
}

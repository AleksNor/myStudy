//
//  CountryDetailTableViewCell.swift
//  Challenge59
//
//  Created by Евгений Карпов on 24.12.2021.
//

import UIKit

class CountryDetailTableViewCell: UITableViewCell {
    var viewModel: CountryDetailTableViewCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.labelText
            content.textProperties.numberOfLines = 0
            contentConfiguration = content
        }
    }
}

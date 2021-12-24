//
//  CountryTableViewCell.swift
//  Challenge59
//
//  Created by Евгений Карпов on 24.12.2021.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    var viewModel: CountryTableViewCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.countryCommonName
            content.secondaryText = viewModel.countryOfficalName
            contentConfiguration = content
        }
    }
}

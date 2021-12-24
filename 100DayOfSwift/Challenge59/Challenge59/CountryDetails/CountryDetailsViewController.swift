//
//  CountryDetailsViewController.swift
//  Challenge59
//
//  Created by Евгений Карпов on 24.12.2021.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CountryDetailsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = 50
        tableView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        setupUI()
    }
    
    func setupUI() {
        guard let imageData = viewModel.flagImage else { return }
        flagImage.image = UIImage(data: imageData)
        countryName.text = viewModel.countryName
        tableView.reloadData()
    }
}

// MARK: - TableView DataSource

extension CountryDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! CountryDetailTableViewCell
        cell.viewModel = viewModel.cellForRow(at: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        return cell
    }
}

extension CountryDetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


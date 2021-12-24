//
//  CountriesListTableViewController.swift
//  Challenge59
//
//  Created by Евгений Карпов on 24.12.2021.
//

import UIKit

class CountriesListTableViewController: UITableViewController {
    
    private var viewModel: CountriesListViewModelProtocol! {
        didSet {
            viewModel.fetchData {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CountriesListViewModel()
        tableView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        title = "Country Informer"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! CountryDetailsViewController
        detailVC.viewModel = sender as? CountryDetailsViewModelProtocol
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryTableViewCell
        cell.viewModel = self.viewModel.cellForRow(at: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewModel = viewModel.viewModelForSelectedRow(at: indexPath)
        performSegue(withIdentifier: "ShowDetails", sender: detailViewModel)
    }
}

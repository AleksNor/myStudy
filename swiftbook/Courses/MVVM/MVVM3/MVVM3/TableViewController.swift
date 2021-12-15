//
//  TableViewController.swift
//  MVVM3
//
//  Created by Евгений Карпов on 15.12.2021.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchMovies { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = viewModel.titleForCell(atIndexPath: indexPath)
        return cell
    }


}


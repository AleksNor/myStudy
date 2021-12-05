//
//  ViewController.swift
//  Project7
//
//  Created by Евгений Карпов on 28.11.2021.
//

import UIKit

class ViewController: UITableViewController {
    // MARK: - Properties
    var petitions = [Petition]()
    var filtredData = [Petition]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "We The People"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle") , style: .plain, target: self, action: #selector(infoButtonPressed))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed))
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    // MARK: - Private methods
    @objc private func infoButtonPressed() {
        let ac = UIAlertController(title: "INFO", message: "This data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc private func searchButtonPressed() {
        let ac = UIAlertController(title: "Search", message: "Please, enter searching data", preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Enter here"
        }
        let okButton = UIAlertAction(title: "OK", style: .default) { okButton in
            self.filtredData = []
            let inputText = ac.textFields?[0].text ?? ""
            DispatchQueue.global(qos: .userInitiated).async {
                if  inputText == "" {
                    self.filtredData = self.petitions
                }
                for petition in self.petitions {
                    if petition.title.lowercased().contains(inputText.lowercased()){
                        self.filtredData.append(petition)
                    }
                }
            }
            self.tableView.reloadData()
        }
        ac.addAction(okButton)
        present(ac, animated: true)
    }
    
    private func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filtredData = jsonPetitions.results
            tableView.reloadData()
        }
    }
}

// MARK: - UITableView Setup
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filtredData[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


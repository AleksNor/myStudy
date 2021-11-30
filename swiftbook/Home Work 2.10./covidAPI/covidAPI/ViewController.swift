//
//  ViewController.swift
//  covidAPI
//
//  Created by Евгений Карпов on 29.11.2021.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var countries: [Country] = []
    var countriesString: [String] = []
    var filteredData: [Country] = []
    let covAPI = "https://covid19.mathdro.id/api/countries"
    let dilteredData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fetchCountryes()

    }
    
    private func fetchCountryes() {
        guard let url = URL(string: covAPI) else {
            return
        }
        let decoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                return
            }
            
            do {
                let jsonCountries = try decoder.decode(Countries.self, from: data)
                self.countries = jsonCountries.countries
                self.countriesString = jsonCountries.getAllName()
                self.filteredData = jsonCountries.countries
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                //print(self.countries[0].country)
            } catch let error {
                print(error)
            }
        } .resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = countries[indexPath.row].name
        var content = cell.defaultContentConfiguration()
        content.text = filteredData[indexPath.row].name
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.currentCountry = filteredData[indexPath.row].name
        vc.currentIso2 = filteredData[indexPath.row].iso2 ?? countries[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == "" {
            filteredData = countries
        } else {
            for country in countries{
                if country.name.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(country)
                }
            }
        }
        self.tableView.reloadData()
    }
}


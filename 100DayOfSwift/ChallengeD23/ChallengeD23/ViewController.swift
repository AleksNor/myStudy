//
//  ViewController.swift
//  ChallengeD23
//
//  Created by Евгений Карпов on 18.11.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries: [String] = []
    var cellTitle: String?
    var anotherCountries = ["uk","us"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flag of the country"
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        countries.sort()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text = checkCountries(countries: countries[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.selectedImage = countries[indexPath.row]
        vc.imageTitle = checkCountries(countries: countries[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkCountries(countries: String) -> String {
        if anotherCountries.contains(countries) {
            return countries.uppercased()
        } else {
            return countries.capitalized
        }
    }


}


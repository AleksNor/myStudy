//
//  DetailViewController.swift
//  covidAPI
//
//  Created by Евгений Карпов on 30.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var confirmedLabel: UILabel!
    
    var currentCountry: String = ""
    var currentIso2: String = ""
    var countryDetail: CountryDetail?
    
    override func viewDidLoad() {
        fetchData()
        super.viewDidLoad()
        
        title = currentCountry

    }
    
    
    private func fetchData() {
        let urlString: String = "https://covid19.mathdro.id/api/countries/\(currentIso2)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let decoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                return
            }
            
            do {
                let jsonCountries = try decoder.decode(CountryDetail.self, from: data)
                DispatchQueue.main.async {
                    self.countryDetail = jsonCountries
                    self.updateLabel()
                }
            } catch let error {
                print(error)
            }
        } .resume()
    }
    
    private func updateLabel() {
        guard let countryDetail = countryDetail else {
            return
        }

        confirmedLabel.text = """
Колличесвто зараженных: \(String(countryDetail.confirmed.value))
Колличество погибших: \(String(countryDetail.deaths.value))
"""
    }
}

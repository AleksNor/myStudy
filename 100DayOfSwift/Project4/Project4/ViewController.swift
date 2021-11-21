//
//  ViewController.swift
//  Project4
//
//  Created by Евгений Карпов on 19.11.2021.
//

import UIKit

class ViewController: UITableViewController{
    
    var websites = ["google.com", "hackingwithswift.com", "yandex.ru"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "True Browser"
        navigationItem.backButtonTitle = "Back"
    }
    
    
    
    //MARK: TabelViewController
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Site", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = websites[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            vc.firstURL = URL(string: "https://" + websites[indexPath.row])!
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


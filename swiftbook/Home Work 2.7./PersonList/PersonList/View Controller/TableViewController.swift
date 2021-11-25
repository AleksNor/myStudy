//
//  ViewController.swift
//  PersonList
//
//  Created by Евгений Карпов on 25.11.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var personArray: [Person] = []
    var dataManager: DataManagerProtocol = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personArray = dataManager.addAllPerson()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! DetailViewController
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        viewController.currentPerson = personArray[indexPath.row]
    }
    
}

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = personArray[indexPath.row].getWholeName()
        cell.contentConfiguration = content
        
        return cell
    }
}


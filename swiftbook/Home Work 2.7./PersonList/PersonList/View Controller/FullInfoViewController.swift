//
//  FullInfoViewController.swift
//  PersonList
//
//  Created by Евгений Карпов on 25.11.2021.
//

import UIKit

class FullInfoViewController: UITableViewController {
    
    var personArray: [Person] = []
    var dataManager: DataManagerProtocol = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personArray = dataManager.addAllPerson()
    }
    
}

extension FullInfoViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return personArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return personArray[section].getWholeName()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.backgroundConfiguration?.backgroundColor = #colorLiteral(red: 0.8460641503, green: 0.9139698744, blue: 0.9580304027, alpha: 1)
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        switch indexPath.row {
        case 0:
            content.text = personArray[indexPath.section].phoneNumber
            content.image = UIImage(systemName: "phone")
        case 1:
            content.text = personArray[indexPath.section].email
            content.image = UIImage(systemName: "mail")
        default:
            break
        }
        
        cell.contentConfiguration = content
        return cell
    }
}

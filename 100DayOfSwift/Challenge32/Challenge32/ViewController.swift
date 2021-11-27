//
//  ViewController.swift
//  Challenge32
//
//  Created by Евгений Карпов on 27.11.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    lazy var shoppingList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPage))
    }
    
    @objc func addNewItem() {
        showAllert()
    }
    
    @objc func refreshPage() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    private func showAllert() {
        let ac = UIAlertController(title: "Adding to shoping list", message: "Add something to shoping list", preferredStyle: .alert)
        
        ac.addTextField() { textField in
            textField.placeholder = "Input here"
        }
        
        let addButton = UIAlertAction(title: "Add", style: .default) {[weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else {
                return
            }
            
            self?.shoppingList.insert(item, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(cancelButton)
        ac.addAction(addButton)
        
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }


}


//
//  ViewController.swift
//  Challenge32
//
//  Created by Евгений Карпов on 27.11.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    lazy var shoppingList: [String] = []
    
    //MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPage))
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        navigationItem.leftBarButtonItems = [refresh, spacer, share]
    }
    
    //MARK: - Private func
    
    @objc func addNewItem() {
        showAllert()
    }
    
    @objc func refreshPage() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareList() {
        let list =  shoppingList.joined(separator: "\sn")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
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
    
}

//MARK: - TabelView

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}


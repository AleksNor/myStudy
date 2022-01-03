//
//  TableViewController.swift
//  Extension
//
//  Created by Евгений Карпов on 03.01.2022.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class TableViewController: UITableViewController {
    
    var pageTitle = ""
    var pageURL = ""
    var defaults = UserDefaults.standard
    var scripts = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }

                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""

                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                    
                    if let scripts = self?.defaults.object(forKey: self?.pageURL ?? "") as? [String: String] {
                        self?.scripts = scripts
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                }
            }
        }
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addJS))
        navigationItem.rightBarButtonItems = [add]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let scripts = defaults.object(forKey: pageURL) as? [String: String] {
            self.scripts = scripts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func cancel() {
        extensionContext?.completeRequest(returningItems: nil)
    }
    
    @objc func addJS() {
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ActionViewController") as? ActionViewController else { return }
        vc.pageURL = pageURL
        vc.pageTitle = pageTitle
        vc.scripts = scripts
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scripts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        var configurator = cell.defaultContentConfiguration()
        let keys = Array(scripts.keys)
        configurator.text = keys[indexPath.row]
        cell.contentConfiguration = configurator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let values = Array(scripts.values)
        guard values[indexPath.row] != "" else { return }
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": values[indexPath.row]]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSwipeInstance = UIContextualAction(style: .normal, title: "Edit") {[unowned self] _, _, _ in
            let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "ActionViewController") as? ActionViewController else { return }
            vc.pageURL = pageURL
            vc.pageTitle = pageTitle
            vc.scripts = scripts
            let keys = Array(scripts.keys)
            let value = Array(scripts.values)
            vc.scriptTitle = keys[indexPath.row]
            vc.scriptText = value[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        actionSwipeInstance.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSwipeInstance = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, _ in
            let keys = Array(scripts.keys)
            scripts.removeValue(forKey: keys[indexPath.row])
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
            defaults.set(scripts, forKey: pageURL)
        }
        return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
    }
    
}

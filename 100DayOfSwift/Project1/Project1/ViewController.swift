//
//  ViewController.swift
//  Project1
//
//  Created by Евгений Карпов on 11.11.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Properties
    var picture = [String]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        loadImageList()
    }
    
    // MARK: - Private methods
    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["Рекомендую приложение \(self.title!)"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    private func loadImageList() {
        DispatchQueue.global(qos: .userInitiated).async {
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                    self.picture.append(item)
                }
            }
            self.picture.sort(by: <)
        }
        tableView.reloadData()
    }
}

// MARK: - UITableView setup
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picture.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = picture[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = picture[indexPath.row]
            vc.titleImage = "Picture \(indexPath.row + 1) of \(picture.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


//
//  ViewController.swift
//  Project1
//
//  Created by Евгений Карпов on 11.11.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var picture = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                picture.append(item)
            }
        }
        picture.sort(by: <)
        print(picture)
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
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
            vc.selctedImage = picture[indexPath.row]
            vc.titleImage = "Picture \(indexPath.row + 1) of \(picture.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}


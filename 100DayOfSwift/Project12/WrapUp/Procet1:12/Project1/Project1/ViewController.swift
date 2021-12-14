//
//  ViewController.swift
//  Project1
//
//  Created by Евгений Карпов on 11.11.2021.
//

import UIKit

class ViewController: UICollectionViewController {
    
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
//        tableView.reloadData()
    }
}

// MARK: - UITableView setup
extension ViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        picture.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? ImageCell else {
            fatalError("Unable to dequqe PersonCell")
        }
        
        let image = picture[indexPath.item]
        
        cell.name.text = image
        guard let imageToLoad = UIImage(named: image) else {
            fatalError("Unable to dequqe PersonCell")
        }
        cell.imageView.image = imageToLoad
        cell.count.text = String(loadData(forKey: image))
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 4/*cell.imageView.bounds.width/2*/
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? ImageCell else {
//            fatalError("Unable to dequqe PersonCell")
//        }
        
        let image = picture[indexPath.item]
        
        updateCount(forKey: image)
        collectionView.reloadData()
        
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                   vc.selctedImage = picture[indexPath.item]
                   vc.titleImage = "Picture \(indexPath.item + 1) of \(picture.count)"
                   navigationController?.pushViewController(vc, animated: true)
               }
    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return picture.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
//        cell.textLabel?.text = picture[indexPath.row]
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            vc.selctedImage = picture[indexPath.row]
//            vc.titleImage = "Picture \(indexPath.row + 1) of \(picture.count)"
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
//    func save(with img: String) {
//        let jsonEncoder = JSONEncoder()
//
//        if let savedData = try? jsonEncoder.encode(Int.self) {
//            let defaults = UserDefaults.standard
//            defaults.set(savedData, forKey: "people")
//        } else {
//            print("Failed to save people")
//        }
//    }
    
    func updateCount(forKey img: String) {
        var count = loadData(forKey: img)
        count += 1
        
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(count) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: img)
        } else {
            print("Failed to save people")
        }
    }
    
    func loadData(forKey img: String) -> Int {
        var result = 0
        let defaults = UserDefaults.standard
        if let savedImageCount = defaults.object(forKey: img) as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                result = try jsonDecoder.decode(Int.self, from: savedImageCount)
            } catch  {
                print("Failed to load image Count")
            }
        }
        return result
    }
}


//
//  StorageManager.swift
//  Challange50
//
//  Created by Евгений Карпов on 16.12.2021.
//

import Foundation

class StorageManager {
    // MARK: - Properties
    
    static let shared = StorageManager()
    private let userDeafults = UserDefaults.standard
    private let photoKey = "photos"
    
    // MARK: - Public methods
    
    public func save(photo: Photo) {
        var photos = fetchData()
        photos.append(photo)
        guard let data = try? JSONEncoder().encode(photos) else {return}
        userDeafults.set(data, forKey: photoKey)
    }
    
    public func removePhoto(for indexPath: IndexPath) {
        var photos = fetchData()
        photos.remove(at: indexPath.row)
        guard let data = try? JSONEncoder().encode(photos) else {return}
        userDeafults.set(data, forKey: photoKey)
    }
    
    public func fetchData() -> [Photo] {
        guard let data = userDeafults.object(forKey: photoKey) as? Data else {return []}
        guard let photos = try? JSONDecoder().decode([Photo].self, from: data) else {return []}
        return photos
    }
    
    public func renamePhoto(for indexPath: IndexPath, and name: String) {
        var photos = fetchData()
        photos[indexPath.row].name = name
        guard let data = try? JSONEncoder().encode(photos) else {return}
        userDeafults.set(data, forKey: photoKey)
    }
}

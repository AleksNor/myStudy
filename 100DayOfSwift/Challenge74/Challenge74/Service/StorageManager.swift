//
//  StorageManager.swift
//  Challenge74
//
//  Created by Евгений Карпов on 08.01.2022.
//

import Foundation

class StorageManager {
  // MARK: - Properties
  static let shared = StorageManager()
  let defaults = UserDefaults.standard
  let noteKey = "notes"
  
  // MARK: - Initialization
  private init() {}
  
  // MARK: - Public function
  func fetchData() -> [Note] {
    guard let data = defaults.object(forKey: noteKey) as? Data else {
      return []
    }
    guard let notes = try? JSONDecoder().decode([Note].self, from: data) else {
      return []
    }
    return notes
  }
  
  func saveData(note: Note) {
    var notes = fetchData()
    notes.append(note)
    guard let data = try? JSONEncoder().encode(notes) else {
      return
    }
    defaults.set(data, forKey: noteKey)
  }
  
  func deleteData(at indexPath: IndexPath) {
    var notes = fetchData()
    notes.remove(at: indexPath.row)
    guard let data = try? JSONEncoder().encode(notes) else {
      return
    }
    defaults.set(data, forKey: noteKey)
  } 
}

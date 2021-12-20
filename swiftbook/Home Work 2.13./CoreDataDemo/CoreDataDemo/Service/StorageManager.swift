//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Евгений Карпов on 17.12.2021.
//

import UIKit
import CoreData

protocol StorageManagerProtocol {
    func saveContext()
    func fetchData() -> [Task]
    func saveData(with taskName: String) -> Task?
    func removeDate(at indexPath: IndexPath)
}


class StorageManager: StorageManagerProtocol {
    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Properties
    
    static var shared = StorageManager()
    
    // MARK: - Private methods
    
    private func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    // MARK: - Public methods
    public func saveContext() {
        if getContext().hasChanges {
            do {
                try getContext().save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    public func fetchData() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try getContext().fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return []
    }
    
    public func saveData(with taskName: String) -> Task? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: getContext()) else { return nil }
        guard let task = NSManagedObject(entity: entity, insertInto: getContext()) as? Task else { return nil }
        task.name = taskName
        saveContext()
        return task
    }
    
    public func removeDate(at indexPath: IndexPath) {
        let tasks = fetchData()
        let task = tasks[indexPath.row]
        getContext().delete(task)
        saveContext()
    }
}

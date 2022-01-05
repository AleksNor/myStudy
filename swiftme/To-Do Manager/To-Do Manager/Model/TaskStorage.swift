//
//  TaskStorage.swift
//  To-Do Manager
//
//  Created by Евгений Карпов on 15.11.2021.
//

import Foundation

protocol TasksStorageProtocol {
    func loadTask() -> [TaskProtocol]
    func saveTask(_ task: [TaskProtocol])
}

class TasksStorage: TasksStorageProtocol {
    func loadTask() -> [TaskProtocol] {
        let testTasks: [TaskProtocol] = [
            Task(title: "Читать книгу", status: .planned, type: .important),
            Task(title: "Починить кота", status: .planned, type: .normal),
            Task(title: "Купить пылесос", status: .planned, type: .normal),
            Task(title: "Сходить в магазин", status: .completed, type: .normal),
            Task(title: "Пригласить на вечеринку Дольфа, Джеки, Леонардо, Уилла и Брюса", status: .planned, type: .important),
        ]
        
        return testTasks
    }
    
    func saveTask(_ task: [TaskProtocol]) {
    }
}

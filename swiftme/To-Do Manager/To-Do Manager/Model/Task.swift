//
//  Task.swift
//  To-Do Manager
//
//  Created by Евгений Карпов on 15.11.2021.
//

import Foundation

enum TaskPriority {
    case normal, important
}

enum TaskStatus: Int {
    case planned,completed
}

protocol TaskProtocol {
    var title: String {get set}
    var status: TaskStatus {get set}
    var type: TaskPriority {get set}
}

struct Task: TaskProtocol {
    var title: String
    var status: TaskStatus
    var type: TaskPriority
}

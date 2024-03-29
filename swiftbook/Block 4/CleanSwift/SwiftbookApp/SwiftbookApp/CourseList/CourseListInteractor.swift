//
//  CourseListInteractor.swift
//  SwiftbookApp
//
//  Created by Евгений Карпов on 04.01.2022.
//  Copyright (c) 2022 Alexey Efimov. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CourseListBusinessLogic {
    func fetchCourses(request: CourseList.ShowCourses.Request)
}

protocol CourseListDataStore {
    var courses: [Course] { get }
}

class CourseListInteractor: CourseListBusinessLogic, CourseListDataStore {
    
    var presenter: CourseListPresentationLogic?
    var courses: [Course] = []
    
    // MARK: Do something
    
    func fetchCourses(request: CourseList.ShowCourses.Request) {
        NetworkManager.shared.fetchData {[weak self] courses in
            self?.courses = courses
            let response = CourseList.ShowCourses.Response(courses: courses)
            self?.presenter?.presentCourses(response: response)
        }
    }
}

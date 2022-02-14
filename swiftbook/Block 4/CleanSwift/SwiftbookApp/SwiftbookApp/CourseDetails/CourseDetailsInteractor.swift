//
//  CourseDetailsInteractor.swift
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

protocol CourseDetailsBusinessLogic {
    var isFavorite: Bool { get }
    func provideCourseDetails(request: CourseDetails.ShowDetails.Request)
    func setFavoriteStatus()
}

protocol CourseDetailsDataStore {
    var course: Course? { get set }
}

class CourseDetailsInteractor: CourseDetailsBusinessLogic, CourseDetailsDataStore {
    
    var presenter: CourseDetailsPresentationLogic?
    var worker: CourseDetailsWorker?
    var course: Course?
    var isFavorite: Bool = false
    
    // MARK: Do something
    
    func provideCourseDetails(request: CourseDetails.ShowDetails.Request) {
        worker = CourseDetailsWorker()
        let imageData = worker?.getImage(from: course?.imageUrl)
        isFavorite = worker?.getFavoriteStatus(for: course?.name ?? "") ?? false
        
        let response = CourseDetails.ShowDetails.Response(
            courseName: course?.name,
            numberOfLessons: course?.numberOfLessons,
            numberOfTests: course?.numberOfTests,
            imageData: imageData,
            isFavorite: isFavorite)
        presenter?.presentCourseDetails(response: response)
    }
    
    func setFavoriteStatus() {
        isFavorite.toggle()
        worker?.setFavoriteStatus(for: course?.name ?? "", with: isFavorite)
        
        let response = CourseDetails.SetFavoriteStatus.Response(isFavorite: isFavorite)
        presenter?.presentFavoriteStatus(response: response)
    }
}
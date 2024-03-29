//
//  CourseDetailsModels.swift
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

enum CourseDetails {
    // MARK: Use cases
    
    enum ShowDetails {
        
        //ViewController -> Interactor
        struct Request {
        }
        
        //Interactor -> Presenter
        struct Response {
            let courseName: String?
            let numberOfLessons: Int?
            let numberOfTests: Int?
            let imageData: Data?
            let isFavorite: Bool
        }
        
        //Presenter -> ViewController
        struct ViewModel {
            let courseName: String
            let numberOfLessons: String
            let numberOfTests: String
            let imageData: Data
            let isFavorite: Bool
        }
    }
    
    enum SetFavoriteStatus {
        
        struct Response {
            let isFavorite: Bool
        }
        
        struct ViewModel {
            let isFavorite: Bool
        }
    }
}

//
//  CourseDetailsRouter.swift
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

@objc protocol CourseDetailsRoutingLogic {
}

protocol CourseDetailsDataPassing {
    var dataStore: CourseDetailsDataStore? { get }
}

class CourseDetailsRouter: NSObject, CourseDetailsRoutingLogic, CourseDetailsDataPassing {
    
    weak var viewController: CourseDetailsViewController?
    var dataStore: CourseDetailsDataStore?
    
}

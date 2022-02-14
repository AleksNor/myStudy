//
//  CourseListConfigurator.swift
//  SwiftbookApp
//
//  Created by Евгений Карпов on 04.01.2022.
//  Copyright © 2022 Alexey Efimov. All rights reserved.
//

import Foundation

class CourseListConfigurator {
    static let shared = CourseListConfigurator()
    
    private init() {}
    
    func configure(with viewController: CourseListViewController) {
        let interactor = CourseListInteractor()
        let presenter = CourseListPresenter()
        let router = CourseListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

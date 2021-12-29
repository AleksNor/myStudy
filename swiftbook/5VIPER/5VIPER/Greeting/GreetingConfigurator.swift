//
//  GreetingConfigurator.swift
//  5VIPER
//
//  Created by Евгений Карпов on 29.12.2021.
//

import Foundation

//Configure отвечает за сборку модуля
protocol GreetingConfoguratorInputProtocol {
    func configure(with view: GreetingViewController)
}

class GreetingConfigurator: GreetingConfoguratorInputProtocol {
    
    //Используем именно ViewConroller, а не protocol, так как
    //Нужно иницализировать presenter
    func configure(with view: GreetingViewController) {
        let presenter = GreetingPresenter(view: view)
        let interactor = GreetingInteractot(presenter: presenter)
        view.presenter = presenter
        presenter.interactor = interactor
    }
    
    
}

//
//  GreetingInteractor.swift
//  5VIPER
//
//  Created by Евгений Карпов on 29.12.2021.
//

import Foundation


//Под этот протокол будет подписан сам Interactor
//Необходимо объявить свойство Presenter для того,
//Чтобы Interactor смог передать свойства обратно в Presenter
protocol GreetingInteractorInputProtocol {
    init(presenter: GreetingInteractorOutputProtocol)
    //Сбор данных для приветствия
    func provideGreetingData()
}

//Под этот протокол будет подписан Presenter
//Должен быть вызван Interactor
//Чтобы передать собранные им данные в Presenter
protocol GreetingInteractorOutputProtocol: AnyObject {
    //GreetingData это данные, которые требуются для реализации данного модуля
    //Тип данных объявлен в Presentor и составлен из свойств модели Person
    func reciveGreetingData(greetingData: GreetingData)
}

class GreetingInteractot: GreetingInteractorInputProtocol {
    
    //Presenter unowned так как явлется родительским классом и имеет сильную ссылку на Interactor
    unowned let presenter: GreetingInteractorOutputProtocol
    
    required init(presenter: GreetingInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideGreetingData() {
        //Interactor взаимодействует с Entity
        //Создаем объект Person
        let person = Person(name: "Tim", surname: "Cook")
        let greetingData = GreetingData(name: person.name, surname: person.surname)
        presenter.reciveGreetingData(greetingData: greetingData)
    }
    
    
}

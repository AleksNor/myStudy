//
//  GreetingPresenter.swift
//  5VIPER
//
//  Created by Евгений Карпов on 29.12.2021.
//

import Foundation

//Presenter явлется тем местом где хранятся состояния всего модуля.
//То есть дублируются сюда только те свойства из модели, которые
//потребуются для реализации именно этого модуля

struct GreetingData {
    let name: String
    let surname: String
}

//Разные протоколы лучше подписывать в extension, так удобнее смотреть методы данных протоколов
class GreetingPresenter: GreetingViewOutputProtocol {
    
    //Свойство view(ViewController), должно быть обхявленно как слабое
    //Так как во ViewController объявленно сильная ссылка на Presenter
    
    unowned let view: GreetingViewInputProtocol
    
    //Свойство Interactor будет сильной ссылкой
    //Для того чтобы понять как выбрать сильную и слабую ссылку
    //Нужно понять последовательность
    //ViewController обращается к Presentor (сильная ссылка будет у VC на Presentor)
    //Так как Presentor по отношению к VC будет дочерним объектом
    //А значит VC должен создать Presentor
    //Presentor обращается к Interactor (сильная ссылка будет у Presentor на Interactor)
    //Так как Interactor по отношению к Presentor будет дочерним объектом
    
    var interactor: GreetingInteractorInputProtocol!
    
    required init(view: GreetingViewInputProtocol) {
        self.view = view
    }
    
    func didTapShowGreetingButton() {
        interactor.provideGreetingData()
    }
}

// MARK: - GreetingInteractorOutputProtocol {
extension GreetingPresenter: GreetingInteractorOutputProtocol {
    func reciveGreetingData(greetingData: GreetingData) {
        let greeting = "Hello \(greetingData.name) \(greetingData.surname)!"
        view.setGreeting(greeting)
    }
    
    
}

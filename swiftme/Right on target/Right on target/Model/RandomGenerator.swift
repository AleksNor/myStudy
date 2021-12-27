//
//  RandomGenerator.swift
//  Right on target
//
//  Created by Евгений Карпов on 07.11.2021.
//

import Foundation

protocol RandomGeneratorProtocol {
    var currentSecreteValue: Int { get }
    func setRandomValue()
}

class RandomGeneratorClass: RandomGeneratorProtocol {
    
    public var currentSecreteValue: Int = 0
    
    private var minValue: Int
    private var maxValue: Int
    
    init(minValue: Int, maxValue: Int) {
        self.minValue = minValue
        self.maxValue = maxValue
    }
    
    public func setRandomValue() {
        currentSecreteValue = Int.random(in: minValue...maxValue)
    }
}


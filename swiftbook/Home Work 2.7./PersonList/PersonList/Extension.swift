//
//  extension.swift
//  PersonList
//
//  Created by Евгений Карпов on 25.11.2021.
//

import Foundation

//MARK: - Array extension for getting random array
public extension Array where Element == Int {
    static func generateRandom(size: Int) -> [Int] {
            guard size > 0 else {
                return [Int]()
            }
            return Array(0..<size).shuffled()
        }
}

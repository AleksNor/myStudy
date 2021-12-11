//
//  UIColor+.swift
//  Project11
//
//  Created by Евгений Карпов on 11.12.2021.
//

import UIKit

extension UIColor {
    convenience init(isRandom: Bool) {
        self.init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
    }
}

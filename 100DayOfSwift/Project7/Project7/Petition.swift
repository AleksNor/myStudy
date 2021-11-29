//
//  Petition.swift
//  Project7
//
//  Created by Евгений Карпов on 28.11.2021.
//

import Foundation


struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

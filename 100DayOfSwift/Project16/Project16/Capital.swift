//
//  Capital.swift
//  Project16
//
//  Created by Евгений Карпов on 25.12.2021.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var wikiPage: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String, wikiPage: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.wikiPage = wikiPage
    }
}

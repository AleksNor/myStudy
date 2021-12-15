//
//  NetworkManager.swift
//  MVVM3
//
//  Created by Евгений Карпов on 15.12.2021.
//

import Foundation

class NetworkManager: NSObject {
    
    func fetchMovies(complition: ([String]) -> ()){
        complition(["Movie 1", "Movie 2", "Movie 3"])
    }
    
    
}

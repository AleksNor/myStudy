//
//  ViewModel.swift
//  MVVM3
//
//  Created by Евгений Карпов on 15.12.2021.
//

import Foundation

class ViewModel: NSObject {
    
    @IBOutlet weak var networkManager: NetworkManager!
    
    private var movies: [String]?
    
    func fetchMovies(complition: @escaping() -> ()) {
        networkManager.fetchMovies { [weak self] movies in
            self?.movies = movies
            complition()
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return movies?.count ?? 0
    }
    
    func titleForCell(atIndexPath indexPath: IndexPath) -> String {
        guard let movies = movies else {
            return ""
        }
        return movies[indexPath.row]

    }
}

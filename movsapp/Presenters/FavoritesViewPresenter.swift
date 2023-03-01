//
//  FavoritesViewPresenter.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import Foundation
import UIKit

protocol FavoritesViewPresenterDelegate {
    func loadFavorites()
}

class FavoritesViewPresenter {
    var delegate: FavoritesViewPresenterDelegate?
    var favoritedMovies: [MoviesResult] = []
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { favorites in
            self.delegate?.loadFavorites()
        } onError: { error in
            print(error.localizedDescription)
        }
    }
    
    func numberOfRowsInSection(_section: Int) -> Int {
        return favoritedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        
        let favoritedMovie = favoritedMovies[indexPath.row]
        cell.setTextAndImageFor(favorite: favoritedMovie)
        
        return cell
    }
}

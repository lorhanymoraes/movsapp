//
//  FavoritesViewPresenter.swift
//  movsapp
//
//  Created by Lorhany Moraes on 03/03/23.
//

import Foundation
import UIKit

protocol FavoritesViewPresenterDelegate {
    func updateFavorites(with favoritedMovies: [MoviesResult])
}

class FavoritesViewPresenter {
    
    var delegate: FavoritesViewPresenterDelegate?
    var favoritedMovies: [MoviesResult] = []
    var moviesResult: MoviesResult?
    
//    func getFavorites() {
//        PersistenceManager.retrieveFavorites { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let favorites):
//                self.delegate?.updateFavorites(with: favorites)
////                self.updateUI(with: favorites)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesTableViewCell else { return .init()}
//        
//        let favoritedMovie = moviesResult[indexPath.row]
//        cell.setTextAndImageFor(favorite: favoritedMovie)
//        
//        return cell
//    }
}

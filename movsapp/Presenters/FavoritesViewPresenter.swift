//
//  FavoritesViewPresenter.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import Foundation
import UIKit

protocol FavoritesViewPresenterDelegate {
    func loadFavorites(with: [MoviesResult])
}

class FavoritesViewPresenter {
    var delegate: FavoritesViewPresenterDelegate?
    var favoritedMovies: [MoviesResult] = []
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
//
//        let favoritedMovie = (favoritedMovies[indexPath.row])
//        cell.setTextAndImageFor(favorite: favoritedMovie)
//
//        return cell
//    }
//    
//    
//    func getFavorites() {
//        PersistenceManager.retrieveFavorites { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let favorites):
//                self.delegate?.loadFavorites(with: favorites)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            
//        }
//    }
    
//    func updateUI(with favoritedMovies: [MoviesResult]) {
//        if favoritedMovies.isEmpty {
//            self.lbNoFavorites?.isHidden = false
//            return
//        } else {
//            self.favoritedMovies = favoritedMovies
//            self.lbNoFavorites?.isHidden = true
//            DispatchQueue.main.async {
//                self.tableViewFavorites.reloadData()
//            }
//        }
//    }
    
    
//    func getFavorites() {
//        PersistenceManager.retrieveFavorites { favorites in
//            self.delegate?.loadFavorites()
//        } onError: { error in
//            print(error.localizedDescription)
//        }
//    }
//    


    
    
}

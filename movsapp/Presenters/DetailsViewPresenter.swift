//
//  DetailsViewPresenter.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import Foundation
import UIKit

protocol DetailsViewPresenterDelegate {
    func filterGenres()
}

class DetailsViewPresenter {
    
    var delegate: DetailsViewPresenterDelegate?
    var moviesInfo: MoviesResult?
    var allGenres: GenresResponse?
    var idGenre: [GenresResponse] = []
    var top10Info: TrendingResult?
    var movieID: Int?
    var isMovieFav = UserDefaults.standard.bool(forKey: "favorites2")
    var favoritesMovie = [MoviesResult]()
    var IDMovie = 1
    
    func getGenre() {
        NetworkServicesMovies.shared.getGenres (onComplete: { (genres) in
            self.allGenres = genres
            self.delegate?.filterGenres()
        }) { (error) in
            switch error {
            case .noResponse:
                print("Erro")
            default:
                print(error)
            }
        }
    }
    
   
    func getMovieInfo() {
        NetworkServicesMovies.shared.getMovieInfo(movieID: moviesInfo?.id ?? top10Info?.id ?? 1, onComplete: { (movies) in
            if let movies = movies {
                dump(movies)
            }
        }) { (error) in
            switch error {
            case .noResponse:
                print("Erro")
            default:
                print(error)
            }
        }
    }

    
//    func addMovieToFavorites(with movie: MoviesResult) {
//        
//        let favoritedMovie = MoviesResult(posterPath: movie.posterPath, adult: movie.adult, overview: movie.overview, releaseDate: movie.releaseDate, genreIds: moviesInfo?.genreIds, id: movie.id, originalTitle: movie.originalTitle, originalLanguage: movie.originalTitle, title: movie.title, backdropPath: movie.backdropPath, popularity: movie.popularity, voteCount: movie.voteCount, video: movie.video, voteAverage: movie.voteAverage)
//
//        
//        PersistenceManager.updateWith(favoritedMovie: favoritedMovie, actionType: .add) { [weak self] error in
//            guard self != nil else { return }
//            
//            guard error != nil else {
//                return
//            }
//            
//        }
//    }
    
//    func getFavorites() {
//
//        PersistenceManager.retrieveFavorites { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let favorites):
//
//                self.favoritesMovie = favorites
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//
//        }
//    }
//
//    func getFavoritesService() {
//        NetworkServicesMovies.shared.getMovieInfo(movieID: (moviesInfo?.id ?? top10Info?.id) ?? 0, onComplete: { (movie) in
//
//            if let movie = movie {
//
//                dump(movie)
//                self.moviesInfo = movie
//                self.addMovieToFavorites(with: movie)
//            }
//
//        })  { (error) in
//            switch error {
//            case .unableToFavorite:
//                print("\(ModelErrorMovies.unableToFavorite)")
//            default:
//                print(error)
//
//            }
//        }
//    }
//
//    func isMovieFavorited() -> Bool {
//        favoritesMovie.contains { favorito in
//            favorito.id == moviesInfo?.id ?? top10Info?.id
//        }
//    }
    
    }
    

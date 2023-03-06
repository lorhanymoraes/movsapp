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
    func updateUIWithDetails()
}

class DetailsViewPresenter {
    
    var delegate: DetailsViewPresenterDelegate?
    var moviesInfo: MoviesResult?
    var trendingInfo: MoviesResult?
    var detailsMovies: MoviesResult?
    var allGenres: GenresResponse?
    var idGenre: [GenresResponse] = []
    var movieID: Int?
    var favoritesMovie = [MoviesResult]()
    
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
    
    func getMoviesInfo() {
        NetworkServicesMovies.shared.getMovieInfo(movieID: moviesInfo?.id ?? trendingInfo?.id ?? 1, onComplete: { (movies) in
            self.detailsMovies = movies
            self.delegate?.updateUIWithDetails()
        }) { (error) in
            switch error {
            case .noResponse:
                print("Erro")
            default:
                print(error)
            }
        }
    }
    
    func getFavorites() {

        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let favorites):

                self.favoritesMovie = favorites

            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
    
    func addMovieToFavorites(with movie: MoviesResult) {
        
        let favoritedMovie = MoviesResult(posterPath: movie.posterPath, adult: movie.adult, overview: movie.overview, releaseDate: movie.releaseDate, genreIds: movie.genreIds ?? moviesInfo?.genreIds, id: movie.id, originalTitle: movie.originalTitle, originalLanguage: movie.originalTitle, title: movie.title, backdropPath: movie.backdropPath, popularity: movie.popularity, voteCount: movie.voteCount, video: movie.video, voteAverage: movie.voteAverage, runtime: movie.runtime ?? moviesInfo?.runtime)

        PersistenceManager.updateWith(favoritedMovie: favoritedMovie, actionType: .add) { [weak self] error in
            guard self != nil else { return }
            
            guard error != nil else {
                return
            }
            
        }
    }
    
    func getFavoritesButton() {
        NetworkServicesMovies.shared.getMovieInfo(movieID: moviesInfo?.id ?? 0, onComplete: { (movie) in
            
            if let movie = movie {
                
                dump(movie)
                self.addMovieToFavorites(with: movie)
            }
            
        })  { (error) in
            switch error {
            case .unableToFavorite:
                print("\(ModelErrorMovies.unableToFavorite)")
            default:
                print(error)
                
            }
        }
    }
}
    

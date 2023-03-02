//
//  DetailsViewController.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import UIKit
import Foundation
import Kingfisher


class DetailsViewController: UIViewController {

    var detailsViewPresenter = DetailsViewPresenter()
    
    @IBOutlet var ivBackground: UIImageView!
    @IBOutlet var ivPoster: UIImageView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbGenre1: UILabel!
    @IBOutlet var lbGenre2: UILabel!
    @IBOutlet var lbOverview: UILabel!
    @IBOutlet var lbScore: UILabel!
    @IBOutlet var lbYear: UILabel!
    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var viewScore: UIView!
    @IBOutlet var ivCompanies: UIImageView!

    @IBOutlet var btExit: UIButton!
    @IBOutlet var btFavorite: UIButton!
    @IBOutlet var lbRunTime: UILabel!
    @IBOutlet var viewsGenres: [UIView]!
    @IBOutlet var viewGenre: UIView!
    @IBOutlet var viewTrailer: UIView!
    
    var infoMovies: MoviesResult?
    var infotop10: TrendingResult?
//    var movieDetails : MovieDetailsResponse?
    var favoritesMovie = [MoviesResult]()
    var isMovieFav = UserDefaults.standard.bool(forKey: "favorites2")
    var infoComapanies: ProductionCompanies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsViewPresenter.delegate = self
        detailsViewPresenter.getGenre()
        detailsViewPresenter.getMovieInfo()
        viewConfiguration()
        imagesConfiguration()
        formattedStrings()
        getFavorites()
        changeButton()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeButton()
    }
    
    @IBAction func btCloseTab(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btActionFavorite(_ sender: UIButton) {
        NetworkServicesMovies.shared.getMovieInfo(movieID: infoMovies?.id ?? infotop10?.id ?? 0, onComplete: { (movie) in
           
            if let movie = movie {
                
                dump(movie)
                self.addMovieToFavorites(with: movie)
                self.btFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
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
    
    func viewConfiguration() {
        viewScore.layer.cornerRadius = viewScore.frame.size.height/2
        lbTitle.text = infoMovies?.originalTitle ?? infotop10?.originalTitle ?? " "
        lbOverview.text = infoMovies?.overview ?? infotop10?.overview
        loading.stopAnimating()
        lbRunTime.text = String(infoMovies?.runtime ?? infotop10?.runtime ?? 0) + " min"
        
        viewsGenres.forEach { view in
            view.layer.cornerRadius = 10
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
        
        }
    }
    
    func formattedStrings() {
        
        var voteAverageString: String? {
            if let vote = infoMovies?.voteAverage?.rounded() ?? infotop10?.voteAverage?.rounded() {
                return String(vote)
            }
            return nil
        }
        self.lbScore.text = voteAverageString
        
        
        var formattedReleaseDate: Date? {
            if let releaseDate = infoMovies?.releaseDate ?? infotop10?.releaseDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-DD"
                return dateFormatter.date(from: releaseDate)
            }
            return nil
        }
        
        var releaseYear: String? {
            if let date = formattedReleaseDate {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_us")
                dateFormatter.dateFormat = "MMMM yyyy"
                return dateFormatter.string(from: date)
            }
            return nil
        }
        self.lbYear.text = releaseYear
        
    }

    
    func imagesConfiguration() {
        
        var posterUrlString: String? {
            if let posterPath = infoMovies?.posterPath ?? infotop10?.posterPath {
                return "https://image.tmdb.org/t/p/w300\(posterPath)"
            }
            return nil
        }
        
        var backUrlString: String? {
            if let backdropPath = infoMovies?.backdropPath ?? infotop10?.backdropPath {
                return "https://image.tmdb.org/t/p/w500\(backdropPath)"
            }
            return nil
        }
        
        var companiesUrlString: String? {
            if let companies =  infoComapanies?.logoPath {
                return "https://image.tmdb.org/t/p/w500\(companies)"
            }
            return nil
        }
        
        if let urlBackdrop = URL(string: backUrlString ?? " ") {
            ivBackground.kf.indicatorType = .activity
            ivBackground.kf.setImage(with: urlBackdrop)
        } else {
            ivBackground.image = nil
        }
        ivPoster.layer.cornerRadius = 15
        
        if let urlPoster = URL(string: posterUrlString ?? " ") {
            ivPoster.kf.indicatorType = .activity
            ivPoster.kf.setImage(with: urlPoster)
        } else {
            ivPoster.image = nil
        }
        
        if let urlCompanies = URL(string: companiesUrlString ?? " ") {
            ivCompanies.kf.indicatorType = .activity
            ivCompanies.kf.setImage(with: urlCompanies)
        } else {
            ivCompanies.image = nil
        }
    }
    
    func filterGenresConfig() {
        let genresIds = infoMovies?.genreIds ?? infotop10?.genreIds
        let genres = detailsViewPresenter.allGenres?.genres.filter({ genre in
            genresIds?.contains(genre.id) ?? false
        })

        var genresName = genres?.map({ genre in
            genre.name
        })
        
        lbGenre1.text = genresName?.first
        lbGenre2.text = genresName?.last

    }
    
    
//    func getFavorites() {
//
//        PersistenceManager.retrieveFavorites { favorites in
//            self.favoritesMovie = favorites ?? []
//        } onError: { error in
//            print(error.localizedDescription)
//        }
//
//    }
//
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
    
    func isMovieFavorited() -> Bool {
        favoritesMovie.contains { favorito in
            favorito.id == infoMovies?.id
        }
    }
    
    
    func changeButton() {
        if isMovieFavorited() {
            btFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            return
        }
    }
    
    
    func addMovieToFavorites(with movie: MoviesResult) {
        
        let favoritedMovie = MoviesResult(posterPath: movie.posterPath, adult: movie.adult, overview: movie.overview, releaseDate: movie.releaseDate, genreIds: infoMovies?.genreIds, id: movie.id, originalTitle: movie.originalTitle, originalLanguage: movie.originalTitle, title: movie.title, backdropPath: movie.backdropPath, popularity: movie.popularity, voteCount: movie.voteCount, video: movie.video, voteAverage: movie.voteAverage, runtime: movie.runtime, productionCompanies: [ProductionCompanies(name: infoComapanies?.name, id: infoComapanies?.id, logoPath: infoComapanies?.logoPath)])

        
        PersistenceManager.updateWith(favoritedMovie: favoritedMovie, actionType: .add) { [weak self] error in
            guard self != nil else { return }
            
            guard error != nil else {
                return
            }
            
        }
    }
    

}

extension DetailsViewController: DetailsViewPresenterDelegate {
    
    func filterGenres() {
        filterGenresConfig()
    }
    
    
}



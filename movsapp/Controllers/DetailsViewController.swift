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
    
    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbGenre1: UILabel!
    @IBOutlet weak var lbGenre2: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var viewScore: UIView!
    @IBOutlet weak var btExit: UIButton!
    @IBOutlet weak var btFavorite: UIButton!
    @IBOutlet weak var lbRunTime: UILabel!
    @IBOutlet var viewsGenres: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsViewPresenter.delegate = self
        detailsViewPresenter.getGenre()
        detailsViewPresenter.getFavorites()
        detailsViewPresenter.getMoviesInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeButton()
        detailsViewPresenter.getGenre()
    }
    
    @IBAction func btCloseTab(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btActionFavorite(_ sender: UIButton) {
        
        detailsViewPresenter.getFavoritesButton()
        self.btFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    func viewConfiguration() {
        viewScore.layer.cornerRadius = viewScore.frame.size.height/2
        lbTitle.text = detailsViewPresenter.detailsMovies?.originalTitle
        lbOverview.text = detailsViewPresenter.detailsMovies?.overview
        loading.stopAnimating()
        
        viewsGenres.forEach { view in
            view.layer.cornerRadius = 10
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
        }
    }
    
    func formattedStrings() {
        
        var lbRuntimeString: String? {
            if let runtime = detailsViewPresenter.detailsMovies?.runtime {
                return String(runtime)
            }
            return nil
        }
        
        self.lbRunTime.text = "Runtime: " + (lbRuntimeString ?? " ") + " min"
        
        var voteAverageString: String? {
            if let vote = detailsViewPresenter.detailsMovies?.voteAverage?.rounded() {
                return String(vote)
            }
            return nil
        }
        
        self.lbScore.text = voteAverageString
        
        var formattedReleaseDate: Date? {
            if let releaseDate = detailsViewPresenter.detailsMovies?.releaseDate  {
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
            if let posterPath = detailsViewPresenter.detailsMovies?.posterPath {
                return "https://image.tmdb.org/t/p/w500\(posterPath)"
            }
            return nil
        }
        
        var backUrlString: String? {
            if let backdropPath = detailsViewPresenter.detailsMovies?.backdropPath  {
                return "https://image.tmdb.org/t/p/w500\(backdropPath)"
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
    }
    
    func filterGenresConfig() {
        let genresIds = detailsViewPresenter.moviesInfo?.genreIds 
        let genres = detailsViewPresenter.allGenres?.genres.filter({ genre in
            genresIds?.contains(genre.id) ?? false
        })
        
        let genresName = genres?.map({ genre in
            genre.name
        })
        
        lbGenre1.text = genresName?.first
        lbGenre2.text = genresName?.last
    }
    
    func isMovieFavorited() -> Bool {
        detailsViewPresenter.favoritesMovie.contains { favorito in
            favorito.id == detailsViewPresenter.detailsMovies?.id
        }
    }
    
    func changeButton() {
        if isMovieFavorited() {
            btFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            return
        } else {
            return
        }
    }
}

extension DetailsViewController: DetailsViewPresenterDelegate {
    func updateUIWithDetails() {
        viewConfiguration()
        imagesConfiguration()
        formattedStrings()
        changeButton()
    }
    
    func filterGenres() {
        filterGenresConfig()
    }
}



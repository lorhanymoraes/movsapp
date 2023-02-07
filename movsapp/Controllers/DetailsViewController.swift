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
    @IBOutlet var lbGenre: UILabel!
    @IBOutlet var lbOverview: UILabel!
    @IBOutlet var lbScore: UILabel!
    @IBOutlet var lbYear: UILabel!
    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var viewScore: UIView!
    @IBOutlet var ivProvider1: UIImageView!
    @IBOutlet var ivProvider2: UIImageView!
    @IBOutlet var btExit: UIButton!
    @IBOutlet var viewGenre: UIView!
    @IBOutlet var viewTrailer: UIView!
    
    var infoMovies: MoviesResult?
    var infotop10: TrendingResult?
    var infoProviders: FlatrateResponse?
    var providers: ProvidersResponse?
    var providederes: [FlatrateResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsViewPresenter.delegate = self
        detailsViewPresenter.getGenre()
        detailsViewPresenter.getProviders()
        viewConfiguration()
        imagesConfiguration()
        formattedStrings()

    }
   
    
    @IBAction func returnPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as? UIViewController else {return}
        self.present(viewController, animated: true, completion: nil);
    }
    
    func viewConfiguration() {
        viewScore.layer.cornerRadius = viewScore.frame.size.height/2
        lbTitle.text = infoMovies?.originalTitle ?? infotop10?.originalTitle ?? " "
        lbOverview.text = infoMovies?.overview ?? infotop10?.overview
        loading.stopAnimating()
        
        viewGenre.layer.cornerRadius = 20
        viewGenre.layer.borderColor = UIColor.gray.cgColor
        viewGenre.layer.borderWidth = 1
    }
    
    func formattedStrings() {
        
        var voteAverageString: String? {
            if let vote = infoMovies?.voteAverage ?? infotop10?.voteAverage?.rounded() {
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
        
        if let urlPoster = URL(string: backUrlString ?? " ") {
            ivBackground.kf.indicatorType = .activity
            ivBackground.kf.setImage(with: urlPoster)
        } else {
            ivBackground.image = nil
        }
        ivPoster.layer.cornerRadius = 15
        
        if let url = URL(string: posterUrlString ?? " ") {
            ivPoster.kf.indicatorType = .activity
            ivPoster.kf.setImage(with: url)
        } else {
            ivPoster.image = nil
        }
    }
    
    func filterGenresConfig() {
        let genresIds = infoMovies?.genreIds ?? infotop10?.genreIds
        let genres = detailsViewPresenter.allGenres?.genres.filter({ genre in
            genresIds?.contains(genre.id) ?? false
        })
        
        let genresName = genres?.map({ genre in
            genre.name
        })
        
        self.lbGenre.text = genresName?.joined(separator: " / ")
    }
    
    func providerImageConfig() {
        
        ivProvider1.layer.cornerRadius = 10
        
        var providerImageString: String? {
            if let providerInfo = infoProviders?.logoPath {
                return "https://image.tmdb.org/t/p/w500\(providerInfo)"
            }
            return nil
        }
        
        if let providerURL = URL(string: providerImageString ?? " ") {
            ivProvider1.kf.indicatorType = .activity
            ivProvider1.kf.setImage(with: providerURL)
        } else {
            ivProvider1.image = nil
        }
    }

}

extension DetailsViewController: DetailsViewPresenterDelegate {
    func presentReturnView() {
        
    }
    
    func loadProviders() {
        providerImageConfig()
    }
    
    func filterGenres() {
        filterGenresConfig()
    }
    
    
}


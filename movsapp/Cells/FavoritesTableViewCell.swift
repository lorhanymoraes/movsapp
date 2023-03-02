//
//  FavoritesTableViewCell.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import UIKit
import Kingfisher

class FavoritesTableViewCell: UITableViewCell {
    
    
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbYear: UILabel!
    @IBOutlet var lbFavorite: UIButton!
    @IBOutlet var ivFavorite: UIImageView!
    
    var favoritedMovies: [MoviesResult] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setTextAndImageFor(favorite: MoviesResult) {
        lbTitle.text = favorite.originalTitle
        
        var posterUrlString: String? {
            if let posterPath = favorite.posterPath {
                return "https://image.tmdb.org/t/p/w300\(posterPath)"
            }
            return nil
        }
        
        if let url = URL(string: posterUrlString ?? " ") {
            ivFavorite.kf.indicatorType = .activity
            ivFavorite.kf.setImage(with: url)
        } else {
            ivFavorite.image = nil
        }
        ivFavorite.layer.cornerRadius = 10
        
        var formattedReleaseDate: Date? {
            if let releaseDate = favorite.releaseDate {
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

}

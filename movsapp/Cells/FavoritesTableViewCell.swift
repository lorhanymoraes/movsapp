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
    }

}

//
//  MoviesTableViewCell.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet var ivMovie: UIImageView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func prepareCell(with movie: MoviesResult) {
        lbTitle.text = movie.originalTitle
        lbDescription.text = movie.overview
        
        var posterUrlString: String? {
            if let posterPath = movie.posterPath {
                return "https://image.tmdb.org/t/p/w500\(posterPath)"
            }
            return nil
        }
        
        ivMovie.layer.cornerRadius = 10
        if let url = URL(string: posterUrlString ?? " ") {
            ivMovie.kf.indicatorType = .activity
            ivMovie.kf.setImage(with: url)
        } else {
            ivMovie.image = nil
        }
    }
}

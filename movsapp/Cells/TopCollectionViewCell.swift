//
//  TopCollectionViewCell.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var ivTop10: UIImageView!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbNumber: UILabel!
    
    func prepareCell(with movie: TrendingResult) {
        lbTitle.text = movie.originalTitle
        ivTop10.layer.cornerRadius = 10
        
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w300\(movie.posterPath ?? "")") {
            ivTop10.kf.indicatorType = .activity
            ivTop10.kf.setImage(with: url)
        } else {
            ivTop10.image = nil
        }
    }
}

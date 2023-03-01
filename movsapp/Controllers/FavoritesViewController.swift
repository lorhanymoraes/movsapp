//
//  FavoritesViewController.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet var topView: UIView!
    @IBOutlet var tableViewFavorites: UITableView!
    
    var favoritesViewPresenter = FavoritesViewPresenter()
    var lbNoFavorites: UILabel?
    var favoritedMovies: [MoviesResult] = []
    var findError: ModelErrorMovies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesViewPresenter.delegate = self
        setupView()
        labelNoFavorites()
        updateUI(with: favoritedMovies)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesViewPresenter.getFavorites()
        tableViewFavorites.reloadData()
    }
    
    func setupView() {
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }

    func labelNoFavorites() {
        let lbNoFavorites = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        lbNoFavorites.center = CGPoint(x: 200, y: 400)
        lbNoFavorites.text = "No Movies?\nSearch and add a new one"
        lbNoFavorites.textAlignment = .center
        lbNoFavorites.adjustsFontSizeToFitWidth = true
        lbNoFavorites.numberOfLines = 0
        lbNoFavorites.textColor = .white
        lbNoFavorites.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        self.view.addSubview(lbNoFavorites)
    }
    
    func updateUI(with favoritedMovies: [MoviesResult]) {
        if favoritedMovies.isEmpty {
            self.lbNoFavorites?.isHidden = false
            return
        } else {
            self.favoritedMovies = favoritedMovies
            self.lbNoFavorites?.isHidden = true
            DispatchQueue.main.async {
                self.tableViewFavorites.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if favoritesViewPresenter.favoritedMovies.count > 0 {
             return favoritesViewPresenter.favoritedMovies.count
        } else {
            tableView.backgroundView = lbNoFavorites
        }
        return favoritesViewPresenter.numberOfRowsInSection(_section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return favoritesViewPresenter.tableView(tableView, cellForRowAt: indexPath)
    }

}

extension FavoritesViewController: FavoritesViewPresenterDelegate {
    func loadFavorites() {
        updateUI(with: favoritesViewPresenter.favoritedMovies)
    }
    
}

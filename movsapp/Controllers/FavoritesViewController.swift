//
//  FavoritesViewController.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoritesViewPresenter = FavoritesViewPresenter()
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableViewFavorites: UITableView!
    
    var lbNoFavorites: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesViewPresenter.delegate = self
        setupView()
        labelNoFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesViewPresenter.getFavorites()
    }
    
    func setupView() {
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        tableViewFavorites.delegate = self
        tableViewFavorites.dataSource = self
    }
    
    func labelNoFavorites() {
        lbNoFavorites = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        lbNoFavorites?.text = "No Movies?\nSearch and add a new one"
        lbNoFavorites?.textAlignment = .center
        lbNoFavorites?.adjustsFontSizeToFitWidth = true
        lbNoFavorites?.numberOfLines = 0
        lbNoFavorites?.textColor = .white
        lbNoFavorites?.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    @IBAction func btUnfavorite(_ sender: UIButton) {
        
        let point = sender.convert(CGPoint.zero, to: tableViewFavorites)
        guard let indexPath = tableViewFavorites.indexPathForRow(at: point) else { return }
        
        PersistenceManager.updateWith(favoritedMovie: favoritesViewPresenter.favoritedMovies[indexPath.row], actionType: .remove) { [weak self] error in
            
            guard let self = self else { return }
            
            self.favoritesViewPresenter.favoritedMovies.remove(at: indexPath.row)
            self.tableViewFavorites.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .left)
            self.tableViewFavorites.reloadData()
        }
    }
    
    func updateUI(with favoritedMovies: [MoviesResult]) {
        if favoritedMovies.isEmpty {
            self.lbNoFavorites?.isHidden = false
        } else {
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
        return favoritesViewPresenter.favoritedMovies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return favoritesViewPresenter.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? DetailsViewController else {return}
        let favoriteMovie = favoritesViewPresenter.favoritedMovies[tableViewFavorites.indexPathForSelectedRow?.row ?? 0]
        viewController.detailsViewPresenter.moviesInfo = favoriteMovie
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}

extension FavoritesViewController: FavoritesViewPresenterDelegate {
    func updateFavorites(with favoritedMovies: [MoviesResult]) {
        updateUI(with: favoritedMovies)
    }
    
}

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
    var favoritedMovies: [MoviesResult] = []
    var findError: ModelErrorMovies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesViewPresenter.delegate = self
        setupView()
        labelNoFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewFavorites.reloadData()
        getFavorites()
        labelNoFavorites()
    }
    
    func setupView() {
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        tableViewFavorites.delegate = self
        tableViewFavorites.dataSource = self
    }
    
    func labelNoFavorites() {
        lbNoFavorites = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        lbNoFavorites?.center = CGPoint(x: 200, y: 400)
        lbNoFavorites?.text = "No Movies?\nSearch and add a new one"
        lbNoFavorites?.textAlignment = .center
        lbNoFavorites?.adjustsFontSizeToFitWidth = true
        lbNoFavorites?.numberOfLines = 0
        lbNoFavorites?.textColor = .white
        lbNoFavorites?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
    }
    
    @IBAction func btUnfavorite(_ sender: UIButton) {
        
        let point = sender.convert(CGPoint.zero, to: tableViewFavorites)
        guard let indexPath = tableViewFavorites.indexPathForRow(at: point) else {return}
        
        PersistenceManager.updateWith(favoritedMovie: favoritedMovies[indexPath.row], actionType: .remove) { [weak self] error in
            
            guard let self = self else { return }
            
            guard let error = self.findError else {
                
                self.favoritedMovies.remove(at: indexPath.row)
                self.tableViewFavorites.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .left)
                self.tableViewFavorites.reloadData()
                return
            }
        }
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
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoritedMovies.count > 0 {
            return favoritedMovies.count
        } else {
            tableView.backgroundView = lbNoFavorites
        }
        return favoritedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesTableViewCell else { return .init()}
        
        let favoritedMovie = favoritedMovies[indexPath.row]
        cell.setTextAndImageFor(favorite: favoritedMovie)
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? DetailsViewController else {return}
        let favoriteMovie = favoritedMovies[tableViewFavorites.indexPathForSelectedRow?.row ?? 0]
        viewController.detailsViewPresenter.moviesInfo = favoriteMovie
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}

extension FavoritesViewController: FavoritesViewPresenterDelegate {
    func loadFavorites(with: [MoviesResult]) {
        updateUI(with: favoritedMovies)
    }
    
}

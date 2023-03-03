//
//  InitialViewController.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import UIKit

class InitialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var initialViewPresenter = InitialViewPresenter()
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var collectionViewTop10: UICollectionView!
    @IBOutlet weak var tableViewAllMovies: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initialViewPresenter.delegate = self
        initialViewPresenter.getAllMovies()
        initialViewPresenter.getTop10()
    }
    
    func setupView() {
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        tableViewAllMovies.delegate = self
        tableViewAllMovies.dataSource = self
        collectionViewTop10.delegate = self
        collectionViewTop10.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return initialViewPresenter.numberOfRowsInSection(_section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return initialViewPresenter.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        return initialViewPresenter.scrollViewDidEndDragging(tableViewAllMovies, scrollView, willDecelerate: decelerate)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        return initialViewPresenter.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAllBooks" {
            guard let controller = segue.destination as? DetailsViewController else {return}
            let showDetail = initialViewPresenter.allMovies?.results?[tableViewAllMovies.indexPathForSelectedRow?.row ?? 0]
            controller.detailsViewPresenter.moviesInfo = showDetail

        } else {
            guard let controller = segue.destination as? DetailsViewController else {return}
            let showTop10 = initialViewPresenter.trendingResponse?.results?[collectionViewTop10.indexPathsForSelectedItems?.first?.row ?? 0]
            controller.detailsViewPresenter.moviesInfo = showTop10
        }
    }
}

extension InitialViewController: InitialViewPresenterDelegate {
    func reloadCollectionViewTopRated() {
        collectionViewTop10.reloadData()
    }
    
    func reloadTableViewAllMovies() {
        tableViewAllMovies.reloadData()
    }
}

extension InitialViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return initialViewPresenter.numberOfRowsInSectionForCollectionTopRated(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return initialViewPresenter.setupTopRatedCollectionCell(collectionView, indexPath: indexPath)
    }
}



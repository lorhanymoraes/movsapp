//
//  InitialViewPresenter.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import Foundation
import UIKit

protocol InitialViewPresenterDelegate {
    func reloadTableViewAllMovies()
    func reloadCollectionViewTopRated()
}

class InitialViewPresenter {
    
    var delegate: InitialViewPresenterDelegate?
    var allMovies: AllMoviesResponse?
    var trendingResponse: TrendingResponse?
    var loadingMovies = false
    var currentPage = 1
    var limit = 20
    var offset = 0
    var total = 0
    var moviesResult: [MoviesResult] = []
    var moviesInfo: MoviesResult?
    var trendingMovies: [TrendingResult] = []
    
    func getAllMovies() {
        loadingMovies = true
        NetworkServicesMovies.shared.loadAllMovie(page: currentPage, onComplete: { (movies) in
            if let movies = movies {
                self.allMovies = movies
                self.moviesResult += movies.results ?? []
                self.currentPage = (self.allMovies?.page ?? 0) + 1
                self.loadingMovies = false
                self.delegate?.reloadTableViewAllMovies()
            }
            
        })  { (error) in
            switch error {
            case .invalidJSON:
                print("JSON Inválido")
            default:
                print(error)
                
            }
        }
    }
    
    func getTop10() {
        loadingMovies = true
        NetworkServicesMovies.shared.loadTopRated(page: currentPage, onComplete: { (top10) in
            if let top10 = top10 {
                self.trendingResponse = top10
                self.trendingMovies += top10.results ?? []
                self.currentPage = (self.trendingResponse?.page ?? 0) + 1
                self.loadingMovies = false
                self.delegate?.reloadCollectionViewTopRated()
            }
            
        })  { (error) in
            switch error {
            case .invalidJSON:
                print("JSON Inválido")
            default:
                print(error)
                
            }
        }

    }
    
  
    func numberOfRowsInSection(_section: Int) -> Int {
        return moviesResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "all movies cell", for: indexPath) as? MoviesTableViewCell else { return UITableViewCell() }
        
       let allMovies = (moviesResult[indexPath.row]) 
        
        cell.prepareCell(with: allMovies)
        
        return cell
    }
    
    func numberOfRowsInSectionForCollectionTopRated(_ section: Int) -> Int {
        return trendingMovies.count - 10
    }
    
    func setupTopRatedCollectionCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "top10 cell", for: indexPath) as? TopCollectionViewCell else {return .init()}
        let topRated = (trendingMovies[indexPath.row])
        cell.prepareCell(with: topRated)
        cell.lbNumber.text = "\(indexPath.row+1)"
        
        return cell
    }

    
    func scrollViewDidEndDragging(_ tableView: UITableView,_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
        {
            if !loadingMovies{
                loadingMovies = true
                self.currentPage = self.currentPage+1
                self.limit = self.limit + 10
                self.offset = self.limit * self.currentPage
                self.getAllMovies()

            }
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            spinner.color = .yellow
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }
}


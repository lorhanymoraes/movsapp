//
//  DetailsViewPresenter.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import Foundation
import UIKit

protocol DetailsViewPresenterDelegate {
    func filterGenres()
    func loadProviders()
    func presentReturnView()
}

class DetailsViewPresenter {
    
    var delegate: DetailsViewPresenterDelegate?
    var moviesInfo: MoviesResult?
    var allGenres: GenresResponse?
    var providers: ProvidersResponse?
    var flatare: FlatrateResponse?
    var infoProviders: [FlatrateResponse] = []
    var idGenre: [GenresResponse] = []
    var top10Info: TrendingResult?
    var providersID = 1
    

    func configurationReturnView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as? UIViewController else {return}
        self.delegate?.presentReturnView()
//        self.present(viewController, animated: true, completion: nil);
    }
    
    func getGenre() {
        NetworkServicesMovies.shared.getGenres (onComplete: { (genres) in
            self.allGenres = genres
            self.delegate?.filterGenres()
        }) { (error) in
            switch error {
            case .noResponse:
                print("Erro")
            default:
                print(error)
            }
        }
    }
    
    func getProviders() {
        NetworkServicesMovies.shared.getProviders(movieID: providers?.id ?? 0, onComplete: { (providers) in
            self.flatare = providers 
            self.delegate?.loadProviders()
        }) { (error) in
            switch error {
            case .noResponse:
                print("Erro")
            default:
                print(error)
            }
        }
    }
    
    }
    

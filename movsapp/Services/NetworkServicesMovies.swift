//
//  NetworkServicesMovies.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import Foundation
import Alamofire

class NetworkServicesMovies {
    
    public static let shared = NetworkServicesMovies()
    
//    static private let baseURL = "https://api.themoviedb.org/3/movie/"
    static private let baseURL = "https://api.themoviedb.org/3/"
    static private let baseURLPopular = "https://api.themoviedb.org/3/movie/popular?"
    static private let apiKey = "b621e030f5e5548ff84999cf7b668c13"
    static private let language = "en-US"
    static private let watchRegion = "BR"
//    static private let page = 1
//    private class Dummy {}
    
    func loadAllMovie(page: Int = 1, onComplete: @escaping (AllMoviesResponse?) -> Void, onError: @escaping (ModelErrorMovies) -> Void) {
        let url = NetworkServicesMovies.baseURL + "/movie/popular?api_key=\(NetworkServicesMovies.apiKey)&language=\(NetworkServicesMovies.language)&page=\(page)"
        print(url)
        guard let url = URL(string: url) else {
            onError(.url)
            return
        }

        AF.request(url).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    onError(.noData)
                    return }
                
                do {
                    let allMovies = try JSONDecoder().decode(AllMoviesResponse.self, from: data)
                    onComplete(allMovies)
                }
                catch {
                    print(error.localizedDescription)
                    onError(.invalidJSON)
                }
                
            } else {
                onError(.responseStatusCode(code: response.response?.statusCode ?? 0))
            }
        }
    }
    
    func loadTopRated(page: Int = 1, onComplete: @escaping (TrendingResponse?) -> Void, onError: @escaping (ModelErrorMovies) -> Void) {
        let topUrl = NetworkServicesMovies.baseURL + "trending/all/day?api_key=\(NetworkServicesMovies.apiKey)&language=\(NetworkServicesMovies.language)&page=\(page)"
        print(topUrl)
        guard let topUrl = URL(string: topUrl) else {
            onError(.url)
            return
        }

        AF.request(topUrl).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    onError(.noData)
                    return }

                do {
                    let trendingMovies = try JSONDecoder().decode(TrendingResponse.self, from: data)
                    onComplete(trendingMovies)
                }
                catch {
                    print(error.localizedDescription)
                    onError(.invalidJSON)
                }

            } else {
                onError(.responseStatusCode(code: response.response?.statusCode ?? 0))
            }
        }
    }
    
//    func loadInfoMovie(movieID: Int,onComplete: @escaping (MoviesResult?) -> Void, onError: @escaping (ModelErrorMovies) -> Void) {
//
//        let movieURL = NetworkServicesMovies.baseURL + "\(movieID)?api_key=\(NetworkServicesMovies.apiKey)&language=\(NetworkServicesMovies.language)"
//        print(movieURL)
//        guard let movieURL = URL(string: movieURL) else {
//            onError(.url)
//            return
//        }
//
//        AF.request(movieURL).responseJSON { (response) in
//            if response.response?.statusCode == 200 {
//                guard let data = response.data else {
//                    onError(.noData)
//                    return }
//
//                do {
//                    let infoMovies = try JSONDecoder().decode(MoviesResult.self, from: data)
//                    onComplete(infoMovies)
//                } catch {
//                    print(error.localizedDescription)
//                    onError(.invalidJSON)
//                }
//
//            } else {
//                onError(.responseStatusCode(code: response.response?.statusCode ?? 0))
//
//            }
//        }
//    }

    func getGenres(onComplete: @escaping (GenresResponse) -> Void, onError: @escaping (ModelErrorMovies) -> Void) {
        let genreURL = NetworkServicesMovies.baseURL + "\("genre/movie/list")?api_key=\(NetworkServicesMovies.apiKey)&language=\(NetworkServicesMovies.language)"
        print(genreURL)

        guard let genreURL = URL(string: genreURL) else {
            onError(.url)
            return
        }

        AF.request(genreURL).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    onError(.noData)
                    return }

                do{
                    let genres = try JSONDecoder().decode(GenresResponse.self, from: data)
                    onComplete(genres)
                } catch {
                    print(error.localizedDescription)
                    onError(.invalidJSON)
                }
            } else {
                onError(.responseStatusCode(code: response.response?.statusCode ?? 0))

            }

        }
    }
    
    
    func getProviders(movieID: Int,onComplete: @escaping (FlatrateResponse?) -> Void, onError: @escaping (ModelErrorMovies) -> Void) {

        let movieURL = NetworkServicesMovies.baseURL + "movie/\(movieID)?api_key=\(NetworkServicesMovies.apiKey)&append_to_response=watch/providers"
        print(movieURL)
        guard let movieURL = URL(string: movieURL) else {
            onError(.url)
            return
        }

        AF.request(movieURL).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    onError(.noData)
                    return }

                do {
                    let providersInfo = try JSONDecoder().decode(FlatrateResponse.self, from: data)
                    onComplete(providersInfo)
                } catch {
                    print(error.localizedDescription)
                    onError(.invalidJSON)
                }

            } else {
                onError(.responseStatusCode(code: response.response?.statusCode ?? 0))

            }
        }
    }

}



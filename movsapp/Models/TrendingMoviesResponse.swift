//
//  TrendingMoviesResponse.swift
//  movsapp
//
//  Created by Lorhany Moraes on 31/01/23.
//

import Foundation


struct TrendingResponse: Codable {
    let page: Int?
    let results: [TrendingResult]?
    let totalResults: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct TrendingResult: Codable, Hashable {
    
    let posterPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    let genreIds: [Int]?
    let id: Int?
    let originalTitle: String?
    let originalLanguage: String?
    let title: String?
    let backdropPath: String?
    let popularity: Float?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?
    
//    var posterUrlString: String? {
//        if let posterPath = posterPath {
//            return "https://image.tmdb.org/t/p/w300\(posterPath)"
//        }
//        return nil
//    }
//
//    var backUrlString: String? {
//        if let backdropPath = backdropPath {
//            return "https://image.tmdb.org/t/p/w500\(backdropPath)"
//        }
//        return nil
//    }
//
//    var moviesId: String? {
//        if let id = id {
//            return "https://api.themoviedb.org/3/movie/\(id)?api_key=b621e030f5e5548ff84999cf7b668c13&language=en-US"
//        }
//        return nil
//    }
//
//
//
//    var formattedReleaseDate: Date? {
//        if let releaseDate = releaseDate {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "YYYY-MM-DD"
//            return dateFormatter.date(from: releaseDate)
//        }
//        return nil
//    }
//
//    var releaseYear: String? {
//        if let date = formattedReleaseDate {
//            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "en_us")
//            dateFormatter.dateFormat = "MMMM yyyy"
//            return dateFormatter.string(from: date)
//        }
//        return nil
//    }
    
    enum CodingKeys: String, CodingKey {
        
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
        
    }
}





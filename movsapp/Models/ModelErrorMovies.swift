//
//  ModelErrorMovies.swift
//  movsapp
//
//  Created by Lorhany Moraes on 31/01/23.
//

import Foundation

enum ModelErrorMovies: Error {
    case url
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
    
    case unableToFavorite
    case alreadyInFavorites
    
}


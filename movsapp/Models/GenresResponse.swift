//
//  GenresResponse.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import Foundation

struct GenresResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}

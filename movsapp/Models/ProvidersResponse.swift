//
//  ProvidersResponse.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import Foundation

struct ProvidersResponse: Codable {
    let id: Int?
    let results: [ProvidersResult]?
}

struct ProvidersResult: Codable {
    let BRResponse: [BRResponse]?
}

struct BRResponse: Codable {
    let link: String?
    let flatrate: [FlatrateResponse]?
}

struct FlatrateResponse: Codable {
    let displayPriority: Int?
    let logoPath: String?
    let providerId: Int?
    let providerName: String?
    
    enum CodingKeys: String, CodingKey {
        case displayPriority = "display_priority"
        case logoPath = "logo_path"
        case providerId = "provider_id"
        case providerName = "provider_name"
    }
    
    
}

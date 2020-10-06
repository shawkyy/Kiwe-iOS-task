//
//  PlacesResponse.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation

struct PlacesResponse: Codable {
    let meta: Meta
    let response: Response
}

struct Meta: Codable {
    let code: Int
    let requestID: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

struct Response: Codable {
    let venues: [Venue]
    let confident: Bool
}

struct Venue: Codable {
    let id, name: String
    let location: Location
    let categories: [Category]
    let referralID: String
    let hasPerk: Bool
    let venuePage: VenuePage?
    
    enum CodingKeys: String, CodingKey {
        case id, name, location, categories
        case referralID = "referralId"
        case hasPerk, venuePage
    }
}

struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon
    let primary: Bool
}

struct Icon: Codable {
    let iconPrefix: String
    let suffix: String
    
    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

struct Location: Codable {
    let address, crossStreet: String?
    let lat, lng: Double
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int
    let postalCode: String?
    let cc: String
    let neighborhood: String?
    let city: String
    let state: String
    let country: String
    let formattedAddress: [String]
}


struct LabeledLatLng: Codable {
    let label: String
    let lat, lng: Double
}


struct VenuePage: Codable {
    let id: String
}

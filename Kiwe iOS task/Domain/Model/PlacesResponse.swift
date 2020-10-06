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
        case requestID
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
    let referralID: ReferralID
    let hasPerk: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, location, categories
        case referralID
        case hasPerk
    }
}

struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon
    let primary: Bool
}

struct Icon: Codable {
    let iconPrefix: String
    let suffix: Suffix

    enum CodingKeys: String, CodingKey {
        case iconPrefix
        case suffix
    }
}

enum Suffix: String, Codable {
    case png = ".png"
}

struct Location: Codable {
    let address: String?
    let lat, lng: Double
    let labeledLatLngs: [LabeledLatLng]
    let distance: Int
    let postalCode: String?
    let cc: Cc
    let city: City?
    let state: State?
    let country: Country
    let formattedAddress: [String]
    let crossStreet: String?
}

enum Cc: String, Codable {
    case ccIN = "IN"
}

enum City: String, Codable {
    case ahmedabad = "Ahmedabad"
    case ahmedabaf = "Ahmedabaf"
    case vadodara = "vadodara"
}

enum Country: String, Codable {
    case india = "India"
}

struct LabeledLatLng: Codable {
    let label: Label
    let lat, lng: Double
}

enum Label: String, Codable {
    case display = "display"
}

enum State: String, Codable {
    case gujarāt = "Gujarāt"
}

enum ReferralID: String, Codable {
    case v1601920959 = "v-1601920959"
}

//
//  ProfileModel.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import Foundation

struct ProfileModel: Decodable {
    let id: Int
    let name: String
    let image: String
    let userName: String
    let followingCount: Int
    let followersCount: Int
    let countryName: String
    let cityName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case userName = "user_name"
        case followingCount = "following_count"
        case followersCount = "followers_count"
        case countryName = "country_name"
        case cityName = "city_name"
    }
}

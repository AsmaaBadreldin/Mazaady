//
//  ProfileModel.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import Foundation

struct ProfileModel {
    let username: String
    let imageURL: String
    let products: [Product]
}

struct Product {
    let id: Int
    let title: String
    let price: Double
    let imageURL: String
    let isSpecial: Bool
    let endDate: Date?
}

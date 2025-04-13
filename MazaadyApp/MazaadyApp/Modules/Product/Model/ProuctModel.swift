//
//  ProuctModel.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let name: String
    let image: String
    let price: Double
    let currency: String
    let offer: Double?
    let endDate: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, image, price, currency, offer
        case endDate = "end_date"
    }
}

//
//  Item.swift
//  СookBook
//
//  Created by Aleksandra Asichka on 2023-02-28.
//

import Foundation

struct Item: Codable {
    let id: Int?
    let title, category, image, bookmark: String?
    let time: Int?
    let isFavorite: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title, category, image, bookmark, time, isFavorite
    }
}

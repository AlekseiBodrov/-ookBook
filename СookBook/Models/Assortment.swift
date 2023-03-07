//
//  Assortiment.swift
//  СookBook
//
//  Created by Aleksandra Asichka on 2023-02-28.
//

import Foundation

struct Assortment: Codable {
    let items: [Item]?
    let categories: [String]?
    let trends: [String]?
}

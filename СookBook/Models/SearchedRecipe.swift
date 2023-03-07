//
//  SearchedRecipe.swift
//  СookBook
//
//  Created by Андрей Колесников on 01.03.2023.
//

import Foundation

//struct SearchedRecipe: Codable {
//    let results: [Result]
//    let number: Int
//}
//
//struct Result: Codable {
//    let id: Int
//    let title: String
//    let image: String
//    let imageType: String
//}

struct SearchedRecipe: Codable {
    let results: [Result]
    let offset, number, totalResults: Int
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}


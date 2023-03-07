//
//  RecipeInformation.swift
//  СookBook
//
//  Created by Андрей Колесников on 01.03.2023.
//

import Foundation

struct RecipeInformation: Codable {
    let readyInMinutes: Int
    let image: String
    let title: String
    let extendedIngredients: [Ingredient]
}

struct Ingredient: Codable {
    let id: Int
    let name: String
    let amount: Double
    let unit: String
}

//
//  RecipeInstruction.swift
//  СookBook
//
//  Created by Андрей Колесников on 01.03.2023.
//

import Foundation

struct RecipeInstruction: Codable {
    let name: String
    let steps: [Steps]
}

struct Steps: Codable {
    let number: Int
    let step: String

}

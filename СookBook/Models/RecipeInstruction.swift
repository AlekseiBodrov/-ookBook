//
//  RecipeInstruction.swift
//  СookBook
//
//  Created by Николай Игнатов on 10.03.2023.
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

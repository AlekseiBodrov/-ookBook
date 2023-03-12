//
//  Model.swift
//  СookBook
//
//  Created by Николай Игнатов on 02.03.2023.
//

import UIKit

struct Dish {
    let dishName: String
    let dishImage: String?
}

struct DishCategory {
    let dishName: String
    let dishImage: UIImage
    let categoryName: String
    let recipe: String
}

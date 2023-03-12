//
//  DatabaseManager.swift
//  СookBook
//
//  Created by Dmitriy Babichev on 09.03.2023.
//
import Foundation
import UIKit

struct DatabaseManager {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var savedRecipes = [Recipe]()

    static func saveRecipe(recipeID: Int64) {
        if !savedRecipes.contains(where: { $0.recipeID == recipeID }) {
            let newRecipe = Recipe(context: self.context)
            newRecipe.recipeID = recipeID

            do {
                try context.save()
            }
            catch {
                print("Saving to database error")
            }
        } else {
            print("Recipe already exist")
        }
    }

    static func deleteRecipe(_ item: Recipe) {
        context.delete(item)

        do {
            try context.save()
        }
        catch {
            print("Deleting from database error")
        }
    }

    static  func fetchRecipes() {
        do {
            savedRecipes = try context.fetch(Recipe.fetchRequest())
        }
        catch {
            print("Fetching recipes from database error")
        }
    }
}

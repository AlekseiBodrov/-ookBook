//
//  NetworkManager.swift
//  СookBook
//
//  Created by Андрей Колесников on 01.03.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    //MARK: - API Key
    private let apiKey = "79ea5edce99f4689acc8b4ec479d1ea3"

    //MARK: - Methods
    func searchRecipes(request: String, completionHandler: @escaping (SearchedRecipe) -> Void) {
        let requestString = request.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&query=\(requestString)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resonse, error in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()

            do {
                let decodedData = try decoder.decode(SearchedRecipe.self, from: data)
                completionHandler(decodedData)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func searchRecipeInstructions(withId id: Int, completionHandler: @escaping ([RecipeInstruction]) -> Void) {
        
        let urlString = "https://api.spoonacular.com/recipes/\(id)/analyzedInstructions?apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([RecipeInstruction].self, from: data)
                completionHandler(decodedData)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getRecipeInformation(withId id: Int, completionHandler: @escaping ((RecipeInformation)) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/\(id)/information?apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else { return }

            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(RecipeInformation.self, from: data)
                completionHandler(decodedData)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}



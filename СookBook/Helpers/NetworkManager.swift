//
//  NetworkManager.swift
//  СookBook
//
//  Created by Андрей Колесников on 01.03.2023.
//

import Foundation

//MARK: RecipeNetworkManagerDelegate
protocol NetworkManagerDelegate {
    func RecipesDidRecive(_ dataFromApi: RecipeData)
    func didFailWithError(error: Error)
}

//MARK: Types of request
enum RequestType {
    case random, categories, search(String)
}


//MARK: - Data parser by URL
struct NetworkManager {


    //77ac3fc6f57d4079889bc3d5c4fd0626 Luiza
    //79ea5edce99f4689acc8b4ec479d1ea3
    //a36d48d5bdf14263b233b3dd3ce16b4a Dmitriy Babichev
    //5920e7d8591b4559b9e6204dadb1647c
    private let apiKey = "f40ffb44d72040d7801e3480f5afcf23"

    private let urlApi = "https://api.spoonacular.com"

    var delegate: NetworkManagerDelegate?

    func getRecipes(_ requestType: RequestType, category: String? = nil) {
        let urlString = currentUrl(requestType, category: category)

        guard let url = URL(string: urlString) else { return  }
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                let recipes = try JSONDecoder().decode(RecipeData.self, from: data)
                self.delegate?.RecipesDidRecive(recipes)
            } catch let error {
                print("Error: \(error)")
                self.delegate?.didFailWithError(error: error)
            }
        }.resume()
    }

    //MARK: - searchRecipe
    func searchRecipe(by title: String, results: @escaping (RecipeData) -> Void) {
        let findTitle = title.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://api.spoonacular.com/recipes/autocomplete?apiKey=\(apiKey)&query=\(findTitle)&number=10"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(RecipeData.self, from: data)
                results(data)
            } catch {
                print(error)
            }
        }.resume()
    }

    //MARK: - searchRecipeById
    func searchRecipeById(by id: Int, results: @escaping (RecipeData.RecipeDescription) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=true&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(RecipeData.RecipeDescription.self, from: data)
                results(data)
            } catch {
                print(error)
            }
        }.resume()
    }

    private func getIngredientImage(imageName: String) -> String {
        let urlString = " https://spoonacular.com/cdn/ingredients_100x100/\(imageName)"
        return urlString
    }
    //MARK: - searchRecipeInstructions
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
    //MARK: - fetchRecipes
    func fetchRecipes(category: String, completion: @escaping ([Int]?, Error?) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&type=\(category)&addRecipeInformation=false"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let results = json?["results"] as? [[String: Any]]
                let recipeIds = results?.compactMap { $0["id"] as? Int }
                completion(recipeIds, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }


    //MARK: - Private current URL method
    private func currentUrl(_ forRequest: RequestType, category: String? = nil) -> String {
        var url = String()
        switch forRequest {
        case .random:
            url = "https://api.spoonacular.com/recipes/complexSearch?number=10&instructionsRequired=true&addRecipeInformation=true&fillIngredients=true&apiKey=\(apiKey)&type=random"
        case .categories:
            if let category = category?.lowercased() {
                let type = category.replacingOccurrences(of: " ", with: "+")
                url = "https://api.spoonacular.com/recipes/complexSearch?number=10&instructionsRequired=true&addRecipeInformation=true&fillIngredients=true&apiKey=\(apiKey)&type=\(type)"
            }
        case .search(let query):
//            let query = "pasta with mush"
            url = "https://api.spoonacular.com/recipes/complexSearch?number=10&instructionsRequired=true&addRecipeInformation=true&fillIngredients=true&apiKey=\(apiKey)&query=\(query)"
            //API Key: a2ee131cb54a4868bad1694c88f60712
            /*
             https://api.spoonacular.com/recipes/complexSearch?number=10&instructionsRequired=true&addRecipeInformation=true&fillIngredients=true&apiKey=a2ee131cb54a4868bad1694c88f60712&query=pasta%20with%20mush
             */
        }
        return url
    }
   
}

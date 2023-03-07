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
    case random, categories
}


//MARK: - Data parser by URL
struct NetworkManager {
    
    private let apiKey = "79ea5edce99f4689acc8b4ec479d1ea3"
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
    func searchRecipe(by title: String, results: @escaping ([SearchData]) -> Void) {
        let findTitle = title.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://api.spoonacular.com/recipes/autocomplete?apiKey=\(apiKey)&query=\(findTitle)&number=25"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode([SearchData].self, from: data)
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
        }
        return url
    }
}

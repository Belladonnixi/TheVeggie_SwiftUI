//
//  Project: TheVeggie
//  RecipeModel.swift
//
//
//  Created by Jessica Ernst on 20.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//

import Foundation

// MARK: - ApiRecipes
struct ApiRecipes: Decodable {
    let from, to, count: Int
    let links: ApiRecipesLinks
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
    let links: HitLinks

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - HitLinks
struct HitLinks: Decodable {
    let linksSelf: SelfClass

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Decodable {
    let href: String
    let title: Title
}

enum Title: String, Decodable {
    case titleSelf = "Self"
}

// MARK: - Recipe
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let ingredients: [Ingredient]
    let calories: Double
    let totalWeight: Double
    let totalTime: Int
    let cuisineType: [String]
    let mealType: [MealType]
    let dishType: [String]?
    
}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
    let foodCategory: String?
    let foodID: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}

enum MealType: String, Decodable {
    case breakfast = "breakfast"
    case brunch = "brunch"
    case lunchDinner = "lunch/dinner"
    case teatime = "teatime"
    case snack = "snack"
}

// MARK: - ApiRecipesLinks
struct ApiRecipesLinks: Decodable {
}


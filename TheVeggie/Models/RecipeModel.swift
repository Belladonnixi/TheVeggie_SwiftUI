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

// MARK: - Welcome
struct Welcome: Codable {
    let from, to, count: Int?
    let links: WelcomeLinks?
    let hits: [Hit]?

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe?
    let links: HitLinks?

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - HitLinks
struct HitLinks: Codable {
    let linksSelf: SelfClass?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let title: Title?
    let href: String?
}

enum Title: String, Codable {
    case titleSelf = "Self"
}

// MARK: - Recipe
struct Recipe: Codable, Identifiable {
    let id: UUID
    let uri: String?
    let label: String?
    let image: String?
    let images: Images?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Int?
    let dietLabels, healthLabels, cautions, ingredientLines: [String]?
    let ingredients: [Ingredient]?
    let calories, totalCO2Emissions: Double?
    let co2EmissionsClass: String?
    let totalWeight: Double?
    let totalTime: Int?
    let cuisineType: [String]?
    let mealType: [MealType]?
    let dishType: [String]?
    let totalNutrients, totalDaily: [String: Total]?
    let digest: [Digest]?
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag: String?
    let schemaOrgTag: SchemaOrgTag?
    let total: Double?
    let hasRDI: Bool?
    let daily: Double?
    let unit: Unit?
    let sub: [Digest]?
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - Images
struct Images: Codable {
    let thumbnail, small, regular, large: Large?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

// MARK: - Large
struct Large: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String?
    let quantity: Double?
    let measure: String?
    let food: String?
    let weight: Double?
    let foodCategory: String?
    let foodID: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}

enum MealType: String, Codable {
    case lunchDinner = "lunch/dinner"
    case snack = "snack"
}

// MARK: - Total
struct Total: Codable {
    let label: String?
    let quantity: Double?
    let unit: Unit?
}

// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
}

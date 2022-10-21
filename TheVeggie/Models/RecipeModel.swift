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
    var from, to, count: Int?
    var links: WelcomeLinks?
    var hits: [Hit]?

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    var recipe: Recipe?
    var links: HitLinks?

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - HitLinks
struct HitLinks: Codable {
    var linksSelf: SelfClass?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    var title: Title?
    var href: String?
}

enum Title: String, Codable {
    case titleSelf = "Self"
}

// MARK: - Recipe
struct Recipe: Codable, Identifiable {
    var id: UUID
    var uri: String?
    var label: String?
    var image: String?
    var images: Images?
    var source: String?
    var url: String?
    var shareAs: String?
    var yield: Int?
    var dietLabels, healthLabels, cautions, ingredientLines: [String]?
    var ingredients: [Ingredient]?
    var calories, totalCO2Emissions: Double?
    var co2EmissionsClass: String?
    var totalWeight: Double?
    var totalTime: Int?
    var cuisineType: [String]?
    var mealType: [MealType]?
    var dishType: [String]?
    var totalNutrients, totalDaily: [String: Total]?
    var digest: [Digest]?
}

// MARK: - Digest
struct Digest: Codable {
    var label, tag: String?
    var schemaOrgTag: SchemaOrgTag?
    var total: Double?
    var hasRDI: Bool?
    var daily: Double?
    var unit: Unit?
    var sub: [Digest]?
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
    var thumbnail, small, regular, large: Large?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

// MARK: - Large
struct Large: Codable {
    var url: String?
    var width, height: Int?
}

// MARK: - Ingredient
struct Ingredient: Codable {
    var text: String?
    var quantity: Double?
    var measure: String?
    var food: String?
    var weight: Double?
    var foodCategory: String?
    var foodID: String?
    var image: String?

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
    var label: String?
    var quantity: Double?
    var unit: Unit?
}

// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
}

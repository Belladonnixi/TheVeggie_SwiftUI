//
//  Project: TheVeggie
//  HomeApiItem.swift
//
//
//  Created by Jessica Ernst on 18.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct HomeApiRecipeRow: View {
    
    let recipe: Recipe
    
    var body: some View {
        HStack {
            DownloadingImageView(url: recipe.image, key: "\(recipe.label)")
                .frame(width: 185, height: 160)
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .center) {
                Text(recipe.label)
                    .font(.headline)
                    .foregroundColor(Color.primary)
                    .frame(height: 160)
                    .lineLimit(5)
                    .scaledToFit()
                    .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.primary.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5)
    }
}

struct HomeApiItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeApiRecipeRow(recipe: Recipe(uri: "uri here", label: "some dish", image: "https://edamam-product-images.s3.amazonaws.com/web-img/5d0/5d066e640df59774510b6e2870df4d81.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEI3%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDDVFaKKNgot2L%2F1G7lkf24pQTeaJXacGD8tdUwck07HAIhAL%2FFxV934K8kAZfk8HPSb769FzxWGLfnWKEgNoiV674vKswECHYQABoMMTg3MDE3MTUwOTg2Igx9xXfNNwCWzTr6hvIqqQSLR2Xa%2FzFbbd5h6uBcRN5ttvc%2Fc6dNgIRjRzUigNVpGKkJHGTq8hFqpAl2ZFbV6G413F84JOdiWNgRY52kub8fHvAa5DahsdlbwcxcaK%2F%2FEUaE%2BtasB1KMy87zyDPb7rUIyoDV5cwNXWsl%2Fmvz7BeXK6xOPAx4u9YM3bp2KeAu7pzRTLR6RLxIKKQ3YpxStRTnPH048nFS6%2FXeJhKXpDnGnphLvOY7hm4nfz1ei79YcCVp8N1MWN8qIMGq%2BKdZqu2IMyaZjN4PeFkohOw2OLtnoMWK1597UZmqgJ%2B%2FYpDUnYSzpPvxd328kSEHR%2Bpc5JLoRa7EaZujiFyOLys8fs4qI6%2BuYmUjNr6gZPWoyhSvLGWlXUeAnL8GlCBCV7z%2BXyfD2JcDY8xGJwi2pK0ui60YvMzcCj9FHpfaOuu7zrsN7ySZPkqM6TW4ON5silAv06DdiWOp7mAxxzwURxOjBjwBsCzbAeBbR0650sCrkYmNEWuc6%2Fjs7eGSN6BdE6Dz6gYSXlLrBP3xYPL3YRnY30P0PLJ8kcs7hGDi6gxKU3O3XTUfHvT%2B5nw0a7HcL5%2BX%2B9BXRVov6dT3yRkyC1e2v%2F1nTLekjLljQ%2FyHkligavMuA8kgI564wNbwTN%2FnNPsG12ZwKsD6SKqKiIuvDxPXtlrkk6Nj8XDD%2Fia9l0%2B4l0cKFrwY5LbLFdocHEfiqGQbaPzqVn6em5X5%2FfKtQ%2BcjRQZSg9MwpE67SqLsMMyL%2F5oGOqgBOyuKMnccq6qCwqbOb6OQF1%2BPsh84f99Yn%2Fi7vXvhTTEZ4orqGw%2FwNgrni3KjS2YHJ%2B4mt%2BUqdLqcay2K7iFfGpjMvIz7UipPHSM%2B2rMvvJDf9b6YDrpGy7g64bafzV0eWk8ofyl1Cam4hg8%2BKCedxtO8ZTG%2FrOqKoPuD1A3YZ25IlqV8z12ubobmrmNvhejRlUQjL5Ksm7k8ZtAKPD4JzCKP7fJVy%2BAi&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20221031T135741Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFM52SQTFU%2F20221031%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=ff0dc6340661d389fcaf10b3219c51f51387807ea94539c10e7c913f1512ce0b", source: "some source", url: "url here", shareAs: "redipe", yield: 4, ingredients: [Ingredient(text: "some", quantity: 2.00, measure: "spoon", food: "some food", weight: 32.00, foodCategory: "something", foodID: "some id", image: "some image")], calories: 35.00, totalWeight: 4878.00, totalTime: 85, cuisineType: ["american"], mealType: [MealType.lunchDinner], dishType: ["some"]))
    }
}

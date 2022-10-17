//
//  Project: TheVeggie
//  TheVeggieApp.swift
//
//
//  Created by Jessica Ernst on 17.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

@main
struct TheVeggieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  RecipeApp.swift
//  Recipe
//
//  Created by jrasmusson on 2022-06-13.
//

import SwiftUI

@main
struct RecipeApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}

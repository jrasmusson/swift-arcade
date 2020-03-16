//
//  GameManager.swift
//  FooFetch
//
//  Created by Jonathan Rasmusson Work Pro on 2020-03-16.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import CoreData

struct GameManager {

    static let shared = GameManager()

    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "GameModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()

    @discardableResult
    func createGame(name: String) -> Game? {
        let context = persistentContainer.viewContext
        
        let game = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context) as! Game // NSManagedObject

        game.name = name

        do {
            try context.save()
            return game
        } catch let createError {
            print("Failed to create: \(createError)")
        }

        return nil
    }

    func fetchGames() -> [Game]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Game>(entityName: "Game")

        do {
            let games = try context.fetch(fetchRequest)
            return games
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return nil
    }
    
    func createFetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    func fetchGam(withName name: String) -> Game? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Game>(entityName: "Game")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let gamess = try context.fetch(fetchRequest)
            return gamess.first
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }

        return nil
    }

    func updateGame(game: Game) {
        let context = persistentContainer.viewContext

        do {
            try context.save()
        } catch let createError {
            print("Failed to update: \(createError)")
        }
    }

    func deleteGame(game: Game) {
        let context = persistentContainer.viewContext
        context.delete(game)

        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }

    func saveContext() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
}


